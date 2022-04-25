import 'package:flutter/material.dart';
import 'package:happy_plants/shared/widgets/util/lists/custom_list_group_switch.dart';
import '../../../../../services/authentication.dart';
import '../../../../../shared/widgets/util/lists/custom_list_tile.dart';

class VacationSettings extends StatelessWidget {
  VacationSettings({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return CustomListGroupSwitch(
        title: 'Vacation',
        isEnabled: false,
        onSwitchChange: (bool value) {
          // TODO
        },
        children: <Widget>[
          CustomListTile(
            title: 'Set vacation until ...',
            subtitle: 'Current: 5 days',
            leading: Icons.beach_access_outlined,
            onTap: () async {
              // TODO
            },
          ),
        ]
    );
  }
}
