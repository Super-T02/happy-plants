import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  // Initialize firebase_auth
  final FirebaseAuth _auth = FirebaseAuth.instance;


  // Sign in with Email
  Future signInEmail(email, password) async {
    try{
      // Try to login the user
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      return result.user!;

    } on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found') {
        // TODO: Alert for user not found
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // TODO: Alert for false password
        print('User or password wrong!');
      }
    }
  }

  // TODO: Sign in with Google

  // Register with Email
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
        print('The password provided is too wak.');

      } else if (e.code == 'email-already-in-use') {
        //TODO: Alter for used email
        print('Email already used!');

      }
    } catch(e) {
      // TODO: Print error
      print(e);
    }
  }

  // TODO: Register with Google
}