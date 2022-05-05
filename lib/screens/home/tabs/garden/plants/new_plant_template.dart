import 'package:flutter/material.dart';
import 'package:happy_plants/screens/home/tabs/garden/plants/new_plant_template_single_entry.dart';
import 'package:happy_plants/shared/models/events.dart';
import 'package:happy_plants/shared/models/plant.dart';
import 'package:happy_plants/shared/utilities/sizes.dart';

import '../../../../../shared/models/garden.dart';
import '../../../../../shared/models/user.dart';
import 'new_plant.dart';

class NewPlantTemplate extends StatefulWidget {
  const NewPlantTemplate({Key? key, required this.user, required this.garden}) : super(key: key);

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
    List<Plant> allTemplatePlants = [];

    allTemplatePlants.add(
      Plant(
        gardenID: widget.garden.id,
        id: '',
        name: 'Bonsai',
        type: 'Bonsai',
        icon: 'bonsai',
        watering: Watering(interval: PeriodsHelper.getPeriodsFromString('weekly'), startDate: DateTime.now(), waterAmount: 100),
        plantSize: PlantSize(begin: 20, now: 25),
        fertilize: Fertilize(interval: PeriodsHelper.getPeriodsFromString('monthly'), startDate: DateTime.now(), amount: 20),
        dustOff: IntervalDateTime(interval: PeriodsHelper.getPeriodsFromString('monthly'), startDate: DateTime.now()),
        potSize: SizeHelper.getSizeFromString('s'),
        repot: IntervalDateTime(interval: PeriodsHelper.getPeriodsFromString('yearly'), startDate: DateTime.now()),
        spray: IntervalDateTime(interval: PeriodsHelper.getPeriodsFromString('weekly'), startDate: DateTime.now()),
        sunDemand: SizeHelper.getSizeFromString('l'),
        temperature: 21,
      //TODO: eventIDs???
      )
    );

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
        children: <Widget>[
          NewPlantTemplateSingleEntry(user: widget.user, garden: widget.garden, plant: allTemplatePlants[0])
          //TODO itterate through all plants
        ],
      ),
    );;
  }
}
