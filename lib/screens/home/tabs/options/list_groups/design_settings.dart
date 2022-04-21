import 'package:flutter/material.dart';

import '../../../../../services/authentication.dart';
import '../../../../../shared/widgets/util/lists/custom_list_group.dart';
import '../../../../../shared/widgets/util/lists/custom_list_tile.dart';

class DesignSettings extends StatelessWidget {
  DesignSettings({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return CustomListGroup(
        title: 'Design',
        children: <Widget>[
          CustomListTile(
            title: 'Change Colorscheme',
            subtitle: 'Current: Dark', // TODO: Dynamic
            leading: Icons.color_lens_outlined,
            onTap: () async {
              // TODO
            },
          ),
        ]
    );
  }
}
