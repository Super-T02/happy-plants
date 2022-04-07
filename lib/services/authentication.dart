import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:happy_plants/services/user.dart';
import 'package:happy_plants/shared/models/user.dart';

/// Authentication service, handing all necessary functions for managing the
/// registration and authentication of users
class AuthService{

  // Initialize firebase_auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  /// Sign in with google
  Future<CustomUser?> signInWithGoogle() async {
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
    if(user != null){
      bool exists = await UserService.userExists(user);

      exists? null : await UserService.generateUser(user);
    }

    return user;
  }

  /// Register with Email
  Future signUpEmail(String name,String email,String password) async{
    try{
      // Try to login the user
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      CustomUser? user = _userFromFirebaseUser(result.user);

      // TODO: Generate new user in db

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

  ///Sign out
  Future signOut() async {
    try{
      await GoogleSignIn().signOut();
      return await _auth.signOut();
    } catch(e){
      // TODO: Handle error
      return null;
    }
  }

}