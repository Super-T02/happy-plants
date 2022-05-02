import 'package:flutter/material.dart';
import 'package:happy_plants/screens/home/tabs/garden/plants/new_plant.dart';
import '../../../../../shared/models/garden.dart';
import '../../../../../shared/models/plant.dart';
import '../../../../../shared/models/user.dart';

class EditPlant extends StatefulWidget {
  const EditPlant({Key? key, required this.user, required this.garden, required this.plant}) : super(key: key);

  final CustomUser user;
  final Garden garden;
  final Plant plant;

  @override
  State<EditPlant> createState() => _EditPlantState();
}

class _EditPlantState extends State<EditPlant> {
  @override
  Widget build(BuildContext context) {
    return NewPlant(garden: widget.garden,user: widget.user,plant: widget.plant);
  }

}
