import 'package:flutter/material.dart';
import 'package:happy_plants/shared/models/user.dart';

import '../../../../../shared/models/settings.dart';
import '../../../../../shared/widgets/dialogs/information_dialog.dart';
import '../../../../../shared/widgets/forms/custom_radio_button.dart';

class ChangeDesignRadioGroup extends StatefulWidget {
  const ChangeDesignRadioGroup({Key? key, required this.user, required this.triggerReload}) : super(key: key);
  final DbUser user;
  final Function triggerReload;

  @override
  State<ChangeDesignRadioGroup> createState() => _ChangeDesignRadioGroupState();
}

class _ChangeDesignRadioGroupState extends State<ChangeDesignRadioGroup> {
  ThemeMode? _mode;


  @override
  void initState() {
    if(widget.user.settings?.designSettings.colorScheme != null) {
      _mode = widget.user.settings!.designSettings.colorScheme!;
    } else {
      widget.user.settings!.designSettings = DesignSettingsModel();
      _mode = widget.user.settings!.designSettings.colorScheme!;
    }
    super.initState();
  }

  changeMode(ThemeMode? newMode) {
    if(newMode != null) {
      setState(() {
        _mode = newMode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InformationDialog(
      title: 'Chose your color theme',
      submitText: 'Ok',
      onSubmit: () {
        //TODO
      },
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
