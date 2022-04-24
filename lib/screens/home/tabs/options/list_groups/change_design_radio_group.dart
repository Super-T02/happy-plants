import 'package:flutter/material.dart';
import 'package:happy_plants/config.dart';
import 'package:happy_plants/services/user.dart';
import 'package:happy_plants/shared/models/user.dart';
import '../../../../../shared/models/settings.dart';
import '../../../../../shared/widgets/dialogs/information_dialog.dart';
import '../../../../../shared/widgets/forms/custom_radio_button.dart';

class ChangeDesignRadioGroup extends StatefulWidget {
  const ChangeDesignRadioGroup({Key? key, required this.user}) : super(key: key);
  final DbUser user;

  @override
  State<ChangeDesignRadioGroup> createState() => _ChangeDesignRadioGroupState();
}

class _ChangeDesignRadioGroupState extends State<ChangeDesignRadioGroup> {
  ThemeMode? _mode;


  @override
  void initState() {
    if(widget.user.settings!.designSettings.colorScheme == null) {
      widget.user.settings!.designSettings = DesignSettingsModel();
      _mode = widget.user.settings!.designSettings.colorScheme!;
    } else {
      _mode = widget.user.settings!.designSettings.colorScheme!;
    }
    super.initState();
  }

  /// changes the mode of the current radio group
  changeMode(ThemeMode? newMode) {
    if(newMode != null) {
      setState(() {
        _mode = newMode;
      });
    }
  }

  /// Handles the submit of the dialog
  void onSubmit() async {
    widget.user.settings!.designSettings.colorScheme = _mode!;
    // TODO: Loading
    await UserService.putNewDbUser(widget.user);
    currentTheme.changeThemeMode(_mode!);
  }

  @override
  Widget build(BuildContext context) {
    return InformationDialog(
      title: 'Chose your color theme',
      submitText: 'Ok',
      onSubmit: onSubmit,
      children: [
        CustomRadioButton<ThemeMode>(
          value: ThemeMode.system,
          text: 'System',
          onChange: changeMode,
          groupValue: _mode,
        ),
        CustomRadioButton<ThemeMode>(
          value: ThemeMode.light,
          text: 'Light',
          onChange: changeMode,
          groupValue: _mode,
        ),
        CustomRadioButton<ThemeMode>(
          text: 'Dark',
          value: ThemeMode.dark,
          onChange: changeMode,
          groupValue: _mode,
        ),
      ],
    );
  }
}
