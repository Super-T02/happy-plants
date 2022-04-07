import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:happy_plants/shared/models/user.dart';

class UserService{
  static final CollectionReference users = FirebaseFirestore.instance.collection('users');

  /// Checks if a user exists in the Firestore
  static Future<bool> userExists(CustomUser user) async {
    try {

      var doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      return doc.exists;

    } on Exception catch (e) {
      // TODO

      return false;
    }
  }

  /// Generate add a new User to the Firestore
  static Future<void> generateUser(CustomUser? user) async {
    if(user != null){
    bool exists = await UserService.userExists(user);

      if(!exists){
        return users.doc(user.uid).set({
          'email': user.email.trim(),
          'name': user.name?.trim(),
        });
      }
    }

    return;
    // TODO: Error handling
  }


}