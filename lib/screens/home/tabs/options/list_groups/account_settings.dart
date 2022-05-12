import 'package:flutter/material.dart';
import 'package:happy_plants/services/user.dart';
import 'package:happy_plants/services/util_service.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:happy_plants/shared/widgets/dialogs/form_dialog.dart';
import 'package:happy_plants/shared/widgets/dialogs/submit_dialog.dart';
import 'package:happy_plants/shared/widgets/util/custom_form_field.dart';
import '../../../../../services/authentication.dart';
import '../../../../../shared/widgets/util/lists/custom_list_group.dart';
import '../../../../../shared/widgets/util/lists/custom_list_tile.dart';

class AccountSettings extends StatelessWidget {
  AccountSettings({Key? key, required this.user}) : super(key: key);
  final DbUser user;
  final AuthService _auth = AuthService();
  final GlobalKey _key = GlobalKey();
  final userControl = TextEditingController();

  /// Opens the dialog for validating a logout
  void openLogoutDialog() {
    showDialog(
        context: _key.currentContext!,
        builder: (BuildContext context) {
          return SubmitDialog(
              title: 'Logout',
              submitText: 'Logout',
              text: 'Do you want to logout?',
              onSubmit: () async {
                await _auth.signOut();
              });
        });
  }

  /// Opens the dialog for changing the username
  void openChangeUsername() {
    showDialog(
        context: _key.currentContext!,
        builder: (BuildContext context) {
          return FormDialog(
              title: 'Change Username',
              onSubmit: () async {
                DbUser newUser = user;
                newUser.name = userControl.text.trim();
                await UserService.putNewDbUser(newUser);
              },
              children: <Widget>[
                CustomFormField(
                    headingText: 'New Username',
                    hintText: 'Enter a new Username',
                    obscureText: false,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: userControl,
                    maxLines: 1,
                    validator: validateUser),
              ]);
        });
  }

  /// Validates the input for the new username
  String? validateUser(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a valid Username';
    } else {
      return null;
    }
  }

  /// Opens the dialog for changing the password
  void openChangePassword() {
    showDialog(
        context: _key.currentContext!,
        builder: (BuildContext context) {
          return SubmitDialog(
              title: 'Change Password',
              text: 'Do you want to change your password?',
              onSubmit: () async {
                await _auth.resetPassword(user.email);
                await _auth.signOut();
                UtilService.showSuccess(
                    'Email sent', 'Check your emails to reset your password');
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      CustomListTile(
        title: 'Logout',
        leading: Icons.logout,
        onTap: openLogoutDialog,
      ),
      CustomListTile(
        title: 'Change username',
        subtitle: 'Current: ${user.name}',
        leading: Icons.person_outline,
        onTap: openChangeUsername,
      ),
    ];

    if (user.isEmailPasswordAuth == true) {
      children.add(
        CustomListTile(
          title: 'Change password',
          leading: Icons.lock_outline,
          onTap: openChangePassword,
        ),
      );
    }

    return CustomListGroup(
      key: _key,
      title: 'Account',
      children: children,
    );
  }
}
