import 'package:flutter/material.dart';

import '../../../../../../shared/models/events.dart';
import '../../../../../../shared/models/garden.dart';
import '../../../../../../shared/models/plant.dart';
import '../../../../../../shared/models/user.dart';
import '../edit_plant.dart';
import '../new_plant.dart';

class NewPlantTemplateSingleEntry extends StatefulWidget {
  const NewPlantTemplateSingleEntry({
    Key? key,
    required this.user,
    required this.garden,
    required this.plant,
    required this.iconForEntry
  }) : super(key: key);

  final CustomUser user;
  final Garden garden;
  final Plant plant;
  final Icon iconForEntry;

  @override
  State<NewPlantTemplateSingleEntry> createState() => _NewPlantTemplateSingleEntryState();
}

class _NewPlantTemplateSingleEntryState extends State<NewPlantTemplateSingleEntry> {
  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness;
    final ThemeData theme = Theme.of(context);

    Text subtitle = Text("Type: " + widget.plant.type);
    if(widget.plant.watering?.waterAmount != null && widget.plant.watering?.interval != null){
      subtitle = Text("Water amount: " + widget.plant.watering!.waterAmount.toString()
          + " ml, Interval: "
          + PeriodsHelper.getStringFromPeriod(widget.plant.watering!.interval)!);
    }

    return Column(
      children: <Widget>[
        ListTile(
          leading: widget.iconForEntry,
          title: Text(widget.plant.name),
          subtitle: subtitle,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    EditPlant(user: widget.user, garden: widget.garden, plant: widget.plant, isTemplate: true,)
                )
            );
          },
          style: theme.listTileTheme.style,
        ),
        const Divider(),
      ],
    );
  }
}
