import 'package:flutter/material.dart';
import 'package:happy_plants/screens/home/tabs/garden/plants/plant_card.dart';
import 'package:happy_plants/shared/models/plant.dart';
import '../../../../../shared/models/garden.dart';
import '../../../../../shared/models/user.dart';

class ListOfPlants extends StatefulWidget {
  const ListOfPlants({Key? key, required this.user, required this.garden}) : super(key: key);

  final CustomUser user;
  final Garden garden;

  @override
  State<ListOfPlants> createState() => _ListOfPlantsState();
}

class _ListOfPlantsState extends State<ListOfPlants> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.garden.name),
        backgroundColor: Theme.of(context).bottomAppBarColor,
        foregroundColor: Theme.of(context).unselectedWidgetColor,
      ),
      body: GridView.count(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(15), //padding from screen to widget
        addAutomaticKeepAlives: true,
        crossAxisCount: 2,
        children: [
          PlantSingle(plant: Plant(gardenID: widget.garden.id, name: 'test1')),
          PlantSingle(plant: Plant(gardenID: widget.garden.id, name: 'test2')),
          PlantSingle(plant: Plant(gardenID: widget.garden.id, name: 'test3')),
        ],
      )
    );
  }
}
