import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_plants/shared/widgets/dialogs/submit_dialog.dart';

import '../../../../../services/authentication.dart';
import '../../../../../shared/widgets/util/lists/custom_list_group.dart';
import '../../../../../shared/widgets/util/lists/custom_list_tile.dart';

class AccountSettings extends StatelessWidget {
  AccountSettings({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();
  final GlobalKey _key = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  /// Opens the dialog for validating a logout
  void openLogoutDialog() {
    showDialog(context: _key.currentContext!, builder: (BuildContext context){
      return SubmitDialog(
          title: 'Logout',
          text: 'Do you want to logout?',
          onSubmit: () async {await _auth.signOut();}
      );
    });
  }

  /// Opens the dialog for changing the username
  void openChangeUsername() {
    
  }

  /// Opens the dialog for changing the password
  void openChangePassword() {
    
  }

  @override
  Widget build(BuildContext context) {


    return CustomListGroup(
        key: _key,
        title: 'Account',
        children: <Widget>[
          CustomListTile(
            title: 'Logout',
            leading: Icons.logout,
            onTap: openLogoutDialog,
          ),
          CustomListTile(
            title: 'Change username',
            leading: Icons.person_outline,
            onTap: openChangeUsername,
          ),
          CustomListTile(
            title: 'Change password',
            leading: Icons.lock_outline,
            onTap: openChangePassword,
          ),
        ]
    );
  }
}
