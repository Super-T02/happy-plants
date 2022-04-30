import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:happy_plants/config.dart';
import 'package:happy_plants/services/event.dart';
import 'package:happy_plants/services/notification.dart';
import 'package:happy_plants/services/user.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:happy_plants/shared/utilities/util.dart';

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

      // Generate all notifications
      await EventService.scheduleAllNotifications(user);

      return user;
    } on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found') {
        // TODO: Alert for false email
      } else if (e.code == 'wrong-password') {
        // TODO: Alert for false password
      }
    } finally {
      Util.endLoading();
    }
  }

  /// Sign in with google
  Future<CustomUser?> signInWithGoogle() async {

    Util.startLoading();

    // Trigger the auth flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credentials = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken
    );

    UserCredential result = await _auth.signInWithCredential(credentials);

    CustomUser? user = _userFromFirebaseUser(result.user);

    // generate user in the Firestore
    await UserService.generateUser(user, false);
    await EventService.scheduleAllNotifications(user);

    Util.endLoading();

    return user;
  }

  /// Register with Email
  Future signUpEmail(String name,String email,String password) async{
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

    } on FirebaseAuthException catch(e){
      if(e.code == 'weak-password') {
        // TODO: Alert for weak password
      } else if (e.code == 'email-already-in-use') {
        //TODO: Alter for used email
      }
    } catch(e) {
      // TODO: Print error
    } finally {
      Util.endLoading();
    }
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
      // TODO: Handle error
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
    } finally {
      Util.endLoading();
    }

    // TODO: error handling
  }
}