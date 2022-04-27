import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happy_plants/screens/home/tabs/garden/plants/plant_card.dart';
import 'package:happy_plants/shared/models/plant.dart';
import 'package:happy_plants/shared/utilities/sizes.dart';
import 'package:provider/provider.dart';
import '../../../../../services/plant.dart';
import '../../../../../shared/models/garden.dart';
import '../../../../../shared/models/user.dart';
import '../new_garden.dart';
import 'new_plant.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
    // Get the current data stream for the authenticated user
    final Stream<QuerySnapshot> _plantStream = PlantService.plantStream(widget.user, widget.garden.id);

    return StreamBuilder<QuerySnapshot>(
      stream: _plantStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError){
          return const Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Document does not exist");
        }
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
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                return PlantSingle(
                    plant: Plant(name: data['name'],
                        icon: data['icon'],
                        id: document.id,
                        type: data['type'],
                        plantSize: PlantSize(begin: data['plantSize.begin'], now: data['plantSize.now']),
                        potSize: SizeHelper.getSizeFromString(data['potSize']),
                        watering: Watering(interval: data['watering{interval}'], waterAmount: data['watering{waterAmount}'], lastTime: data['watering{lastTime}']),
                        spray: IntervalDateTime(interval: data['spray.interval'], lastTime: data['spray.lastTime']),
                        fertilize: Fertilize(interval: data['fertilize.interval'], amount: data['fertilize.amount'], lastTime: data['fertilize.lastTime']),
                        temperature: data['temperature'],
                        sunDemand: SizeHelper.getSizeFromString(data['sunDemand']),
                        repot: IntervalDateTime(interval: data['repot.interval'], lastTime: data['repot.lastTime']),
                        dustOff: IntervalDateTime(interval: data['dustOff.interval'], lastTime: data['dustOff.lastTime']),
                        gardenID: widget.garden.id),
                    garden: widget.garden);
              }).toList(),
            ),
          floatingActionButton: SpeedDial(
            icon: Icons.add,
            activeIcon: Icons.close,
            iconTheme: IconThemeData(size: 35, color: Theme.of(context).unselectedWidgetColor),
            backgroundColor: Theme.of(context).primaryColor,
            visible: true,
            curve: Curves.bounceIn,
            children: [
              // FAB 1
              SpeedDialChild(
                  child: const Icon(Icons.add_circle_outline_outlined),
                  backgroundColor: Theme.of(context).primaryColor,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewPlant(user: widget.user, garden: widget.garden))
                    );
                  },
                  label: 'own',
                  labelStyle: Theme.of(context).textTheme.bodyText1
              ),
              // FAB 2
              SpeedDialChild(
                  child: const Icon(Icons.library_books_outlined), //todo right icon
                  backgroundColor: Theme.of(context).primaryColor,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('from template to be implemented!')));
                  },
                  label: 'template',
                  labelStyle: Theme.of(context).textTheme.bodyText1
              )
            ],
          ),
        );
      }
    );



  }
}
