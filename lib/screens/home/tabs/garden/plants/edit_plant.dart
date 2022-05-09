import 'package:flutter/material.dart';
import 'package:happy_plants/screens/home/tabs/garden/plants/new_plant.dart';
import '../../../../../shared/models/garden.dart';
import '../../../../../shared/models/plant.dart';
import '../../../../../shared/models/user.dart';

class EditPlant extends StatefulWidget {
  const EditPlant({Key? key, required this.user, required this.garden, required this.plant, this.isTemplate}) : super(key: key);

  final CustomUser user;
  final Garden garden;
  final Plant plant;
  final bool? isTemplate;

  @override
  State<EditPlant> createState() => _EditPlantState();
}

class _EditPlantState extends State<EditPlant> {
  @override
  Widget build(BuildContext context) {
    if(widget.isTemplate != null && widget.isTemplate == true){
      return NewPlant(garden: widget.garden,user: widget.user, isNew: true,plant: widget.plant);
    }
    else{
      return NewPlant(garden: widget.garden,user: widget.user, isNew: false,plant: widget.plant);
    }

  }

}
