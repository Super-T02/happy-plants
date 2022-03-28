import 'package:firebase_auth/firebase_auth.dart';
import 'package:happy_plants/shared/models/user.dart';

/// Authentication service, handing all necessary functions for managing the
/// registration and authentication of users
class AuthService{

  // Initialize firebase_auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Build our custom user
  CustomUser? _userFromFirebaseUser(User? user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  /// Auth change user stream
  Stream<CustomUser?> get user {
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }

  /// Sign in with Email
  Future signInEmail(email, password) async {
    try{
      // Try to login the user
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      return _userFromFirebaseUser(result.user);

    } on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found') {
        // TODO: Alert for false email
      } else if (e.code == 'wrong-password') {
        // TODO: Alert for false password
      }
    }
  }

  // TODO: Sign in with Google

  /// Register with Email
  Future registerEmail(email, password) async{
    try{
      // Try to login the user
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

    } on FirebaseAuthException catch(e){
      if(e.code == 'weak-password') {
        // TODO: Alert for weak password
      } else if (e.code == 'email-already-in-use') {
        //TODO: Alter for used email
      }
    } catch(e) {
      // TODO: Print error
    }
  }

  // TODO: Register with Google

  ///Sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
      // TODO: Handle error
      return null;
    }
  }
}