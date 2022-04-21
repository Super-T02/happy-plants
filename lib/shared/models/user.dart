import 'package:happy_plants/shared/models/settings.dart';

/// Custom user for this application
class CustomUser {
  final String uid;
  String email;
  String? name;
  Settings? settings;

  // Constructor
  CustomUser({ required this.uid, required this.email, this.name, this.settings});
}

class DbUser extends CustomUser{
  DbUser({required this.isEmailPasswordAuth ,required String uid, required String email, Settings? settings, String? name})
      : super(uid: uid, email: email, settings: settings, name: name);

  bool isEmailPasswordAuth;
}