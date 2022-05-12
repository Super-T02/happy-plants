import 'package:flutter/material.dart';
import 'package:happy_plants/screens/home/tabs/options/list_groups/change_design_radio_group.dart';
import 'package:happy_plants/shared/models/settings.dart';
import '../../../../../shared/models/user.dart';
import '../../../../../shared/widgets/util/lists/custom_list_group.dart';
import '../../../../../shared/widgets/util/lists/custom_list_tile.dart';

class DesignSettings extends StatelessWidget {
  DesignSettings({Key? key, required this.user}) : super(key: key);
  final GlobalKey _key = GlobalKey();
  final DbUser user;

  /// Opens the dialog for changing the theme
  void openThemeDialog() {
    showDialog(
        context: _key.currentContext!,
        builder: (BuildContext context) {
          ThemeMode mode;

          user.settings ??= CustomSettings.getDefault();

          if (user.settings!.designSettings.colorScheme == null) {
            user.settings!.designSettings = DesignSettingsModel();
            mode = user.settings!.designSettings.colorScheme!;
          } else {
            mode = user.settings!.designSettings.colorScheme!;
          }

          return ChangeDesignRadioGroup(user: user);
        });
  }

  String getCurrentColorScheme() {
    switch (user.settings?.designSettings.colorScheme) {
      case ThemeMode.system:
        return "Current: System";
      case ThemeMode.light:
        return "Current: Light";
      case ThemeMode.dark:
        return "Current: Dark";
      default:
        return " ";
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomListGroup(key: _key, title: 'Design', children: <Widget>[
      CustomListTile(
        title: 'Change Colorscheme',
        subtitle: getCurrentColorScheme(),
        leading: Icons.color_lens_outlined,
        onTap: openThemeDialog,
      ),
    ]);
  }
}
