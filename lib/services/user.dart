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
  static Future<void> generateUser(CustomUser? user, bool isEmailPasswordAuth) async {
    if(user != null){
    bool exists = await UserService.userExists(user);

      if(!exists){
        return users.doc(user.uid).set({
          'email': user.email.trim(),
          'name': user.name?.trim(),
          'isEmailPasswordAuth': isEmailPasswordAuth,
        });
      }
    }

    return;
    // TODO: Error handling
  }

  /// Returns the userdata mapped to the dbUser
  static Future<DbUser> getCurrentDbUser(String userId) async {
    final snapshot = await users.doc(userId).get();
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return DbUser(
        isEmailPasswordAuth: data['isEmailPasswordAuth'],
        uid: userId,
        email: data['email'],
        settings: data['settings'],
        name: data['name']
    );
  }

  /// Replaces the db entry for the user
  static Future<void> putNewDbUser(DbUser user){
    return users.doc(user.uid).set({
      "isEmailPasswordAuth": user.isEmailPasswordAuth,
      "email": user.email,
      "settings": user.settings?.toJSON,
      "name": user.name,
    });

    // TODO: Error handling

  }

  /// Generates a snapshot stream of the user instance
  static Stream<DbUser> userStream(String id) {
    final snapshot = FirebaseFirestore.instance.collection('users').doc(id).snapshots();



    return snapshot.map((data) {
      return DbUser(
        isEmailPasswordAuth: data['isEmailPasswordAuth'],
        uid: data['uid'],
        email: data['email'],
        name: data['name'],
        settings: data['settings'],
      );
    });
  }


}