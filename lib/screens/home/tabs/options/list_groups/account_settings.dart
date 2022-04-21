import 'package:flutter/material.dart';

import '../../../../../services/authentication.dart';
import '../../../../../shared/widgets/util/lists/custom_list_group.dart';
import '../../../../../shared/widgets/util/lists/custom_list_tile.dart';

class AccountSettings extends StatelessWidget {
  AccountSettings({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return CustomListGroup(
        title: 'Account',
        children: <Widget>[
          CustomListTile(
            title: 'Logout',
            leading: Icons.logout,
            onTap: () async {
              await _auth.signOut();
            },
          ),
          CustomListTile(
            title: 'Change username',
            leading: Icons.person_outline,
            onTap: () async {
              // TODO
            },
          ),
          CustomListTile(
            title: 'Change password',
            leading: Icons.lock_outline,
            onTap: () async {
              // TODO
            },
          ),
        ]
    );
  }
}
