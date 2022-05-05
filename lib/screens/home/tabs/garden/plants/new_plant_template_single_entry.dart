import 'package:flutter/material.dart';

import '../../../../../shared/models/garden.dart';
import '../../../../../shared/models/plant.dart';
import '../../../../../shared/models/user.dart';
import 'edit_plant.dart';
import 'new_plant.dart';

class NewPlantTemplateSingleEntry extends StatefulWidget {
  const NewPlantTemplateSingleEntry({Key? key, required this.user, required this.garden, required this.plant}) : super(key: key);

  final CustomUser user;
  final Garden garden;
  final Plant plant;

  @override
  State<NewPlantTemplateSingleEntry> createState() => _NewPlantTemplateSingleEntryState();
}

class _NewPlantTemplateSingleEntryState extends State<NewPlantTemplateSingleEntry> {
  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness;
    final ThemeData theme = Theme.of(context);

    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.face),
          title: Text(widget.plant.type),
          subtitle: Text("Watering: " + widget.plant.watering.toString()),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditPlant(user: widget.user, garden: widget.garden, plant: widget.plant, isTemplate: true,))
            );
          },
          style: theme.listTileTheme.style,
        ),
        const Divider(),
      ],
    );
  }
}
