import 'package:flutter/material.dart';
import 'package:happy_plants/screens/home/tabs/options/list_groups/change_design_radio_group.dart';
import 'package:happy_plants/shared/models/settings.dart';
import '../../../../../services/authentication.dart';
import '../../../../../shared/models/user.dart';
import '../../../../../shared/widgets/util/lists/custom_list_group.dart';
import '../../../../../shared/widgets/util/lists/custom_list_tile.dart';

class DesignSettings extends StatelessWidget {
  DesignSettings({Key? key, required this.user, required this.triggerReload}) : super(key: key);
  final GlobalKey _key = GlobalKey();
  final AuthService _auth = AuthService();
  final DbUser user;
  final Function triggerReload;

  /// Opens the dialog for changing the theme
  void openThemeDialog() {
    showDialog(context: _key.currentContext!, builder: (BuildContext context){
      ThemeMode mode;

      if(user.settings?.designSettings.colorScheme != null) {
        mode = user.settings!.designSettings.colorScheme!;
      } else {
        user.settings!.designSettings = DesignSettingsModel();
        mode = user.settings!.designSettings.colorScheme!;
      }

      return ChangeDesignRadioGroup(user: user,triggerReload: triggerReload,);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomListGroup(
      key: _key,
      title: 'Design',
      children: <Widget>[
        CustomListTile(
          title: 'Change Colorscheme',
          subtitle: 'Current: Dark', // TODO: Dynamic
          leading: Icons.color_lens_outlined,
          onTap: openThemeDialog,
        ),
      ]
    );
  }
}
