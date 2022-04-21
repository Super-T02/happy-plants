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