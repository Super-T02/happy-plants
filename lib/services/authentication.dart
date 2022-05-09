import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:happy_plants/config.dart';
import 'package:happy_plants/services/event.dart';
import 'package:happy_plants/services/notification.dart';
import 'package:happy_plants/services/settings.dart';
import 'package:happy_plants/services/user.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:happy_plants/shared/utilities/util.dart';

import 'util_service.dart';

/// Authentication service, handing all necessary functions for managing the
/// registration and authentication of users
class AuthService{

  // Initialize firebase_auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final NotificationService notificationService = NotificationService();

  /// Build our custom user
  CustomUser? _userFromFirebaseUser(User? user) {
    return user != null ? CustomUser(
        uid: user.uid,
        email: user.email!,
        name: user.displayName
    ) : null;
  }

  /// Auth change user stream
  Stream<CustomUser?> get user {
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }

  /// Sign in with Email
  Future signInEmail(email, password) async {
    try{
      Util.startLoading();

      // Try to login the user
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      CustomUser? user =  _userFromFirebaseUser(result.user);

      // Load settings in system storage
      user != null? SettingsService.loadSettingsFromCloud(user.uid) : null;

      // Generate all notifications
      await EventService.scheduleAllNotifications(user);

      return user;
    } on FirebaseAuthException catch(e){
      Util.endLoading();
      if(e.code == 'user-not-found' || e.code == 'wrong-password') {
        UtilService.showError('User or password wrong', '');
      }
    } catch (_) {
      Util.endLoading();
      UtilService.showError('Unknown Exception', '');
    }
  }

  /// Sign in with google
  Future<CustomUser?> signInWithGoogle() async {

    Util.startLoading();
    CustomUser? user;

    // Trigger the auth flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken
      );

      UserCredential result = await _auth.signInWithCredential(credentials);

      user = _userFromFirebaseUser(result.user);

      // Load settings in system storage
      user != null? SettingsService.loadSettingsFromCloud(user.uid) : null;

      // generate user in the Firestore
      await UserService.generateUser(user, false);
      await EventService.scheduleAllNotifications(user);

    } on PlatformException catch (e) {
      UtilService.showError('Authentication error', e.message);
    } on Exception catch (e) {
      UtilService.showError('Internal Error', 'Unknown Error');

    } finally {
      Util.endLoading();
    }

    return user;
  }

  /// Register with Email
  Future<bool> signUpEmail(String name,String email,String password) async{
    bool success = false;

    try{
      Util.startLoading();

      // Try to login the user
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      CustomUser? user = _userFromFirebaseUser(result.user);
      user?.name = name;

      // generate user in the Firestore
      await UserService.generateUser(user, true);
      success = true;
      Util.endLoading();
    } on FirebaseAuthException catch(e){

      if(e.code == 'weak-password') {
        Util.endLoading();
        UtilService.showError(
            'Weak Password',
            'Please use at least one digit, uppercase letter, lower case letter'
        );
      } else if (e.code == 'email-already-in-use') {
        Util.endLoading();
        UtilService.showError(
            'Email already in use',
            'Please use another email'
        );
      } else {
        Util.endLoading();
        UtilService.showError(
            'Something went wrong',
            'Please try another email'
        );
      }

    } catch(e) {
      Util.endLoading();
      UtilService.unknownError();

    }

    return success;
  }

  ///Sign out
  Future signOut() async {
    try{
      Util.startLoading();

      // Delete all notifications
      await notificationService.cancelAllNotifications();

      await GoogleSignIn().signOut();
      return await _auth.signOut();
    } catch(e){
      Util.endLoading();
      UtilService.unknownError();
      return null;
    } finally {
      modeInit = false;
      Util.endLoading();
    }
  }

  ///Reset Password
  Future resetPassword(String email) async {
    try{
      Util.startLoading();
      await _auth.sendPasswordResetEmail(email: email);
      Util.endLoading();
    } catch (e) {
      Util.endLoading();
      UtilService.unknownError();
    }
  }
}