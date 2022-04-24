import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happy_plants/config.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:happy_plants/shared/models/settings.dart';

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
          'settings': CustomSettings.getDefault().toJSON(),
        });
      }
    }

    return;
    // TODO: Error handling
  }

  /// Replaces the db entry for the user
  static Future<void> putNewDbUser(DbUser user){
    user.settings ??= CustomSettings.getDefault();

    return users.doc(user.uid).set({
      "isEmailPasswordAuth": user.isEmailPasswordAuth,
      "email": user.email,
      "settings": user.settings!.toJSON(),
      "name": user.name,
    });

    // TODO: Error handling

  }

  /// Generates a snapshot stream of the user instance
  Stream<DbUser?> userStream(String? id) {

    if(id == null) return Stream.value(null);

    // ID is not null:
    final snapshot = FirebaseFirestore.instance.collection('users').doc(id).snapshots();

    return snapshot.map((data) {
      DbUser user = DbUser(
        isEmailPasswordAuth: data['isEmailPasswordAuth'],
        uid: id,
        email: data['email'],
        name: data['name'],
      );

      if(data['settings'] == null) {
        user.settings = CustomSettings.getDefault();

      } else {
        ThemeMode _mode;

        // map time of day
        TimeOfDay _notificationTime = TimeOfDay(
            hour:  data['settings']['pushNotificationSettings']['notificationTime']['hour'],
            minute:  data['settings']['pushNotificationSettings']['notificationTime']['minute']
        );

        // chose theme mode
        switch(data['settings']['designSettings']['colorScheme']){
          case 'ThemeMode.system':
            _mode = ThemeMode.system;
            break;
          case 'ThemeMode.light':
            _mode = ThemeMode.light;
            break;
          case 'ThemeMode.dark':
            _mode = ThemeMode.dark;
            break;
          default:
            throw Error();
            break;
        }

        // Build the user Settings
        user.settings = CustomSettings(
          designSettings: DesignSettingsModel(
            colorScheme: _mode,
          ),
          pushNotificationSettings: PushNotificationSettingsModel(
            enabled: data['settings']['pushNotificationSettings']['enabled'],
            notificationTime: _notificationTime,
          ),
          vacationSettings: VacationSettingsModel(
            enabled: data['settings']['vacationSettings']['enabled'],
            duration: 5, // TODO: if vacation mode is implemented this line needs to be replaced
          ),
        );
      }

      return user;
    });
  }


}