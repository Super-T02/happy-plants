import 'package:flutter/material.dart';
import 'package:happy_plants/screens/home/tabs/garden/plants/template/new_plant_template_single_entry.dart';
import 'package:happy_plants/shared/models/plant.dart';
import '../../../../../../shared/models/garden.dart';
import '../../../../../../shared/models/user.dart';
import 'all_templates.dart';

class NewPlantTemplate extends StatefulWidget {
  const NewPlantTemplate({Key? key, required this.user, required this.garden})
      : super(key: key);

  final CustomUser user;
  final Garden garden;

  @override
  State<NewPlantTemplate> createState() => _NewPlantTemplateState();
}

class _NewPlantTemplateState extends State<NewPlantTemplate> {
  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness;
    final ThemeData theme = Theme.of(context);
    List<Widget> allTemplateWidgets = [];
    List<Plant> allTemplatePlants = Templates.getAllTemplates(widget.garden.id);

    for (Plant plant in allTemplatePlants) {
      allTemplateWidgets.add(NewPlantTemplateSingleEntry(
          user: widget.user,
          garden: widget.garden,
          plant: plant,
          iconForEntry: const Icon(Icons.yard)));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Select Template"),
        backgroundColor: Theme.of(context).bottomAppBarColor,
        foregroundColor: Theme.of(context).unselectedWidgetColor,
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(15), //padding from screen to widget
        addAutomaticKeepAlives: true,
        children: allTemplateWidgets,
      ),
    );
    ;
  }
}
