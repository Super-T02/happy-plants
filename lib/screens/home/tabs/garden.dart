import 'package:flutter/material.dart';
import 'package:happy_plants/screens/home/tabs/garden/list_of_gardens.dart';

class Garden extends StatefulWidget {
  const Garden({Key? key}) : super(key: key);

  @override
  State<Garden> createState() => _GardenState();
}

class _GardenState extends State<Garden> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          ListOfGardens(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to new garden form
          Navigator.pushNamed(
            context,
            '/newGarden'
          );
        },
        backgroundColor: Theme.of(context).primaryColor,

        child: Icon(
          Icons.add,
          size: 35,
          color: Theme.of(context).unselectedWidgetColor, //scaffoldBackgroundColor for turned around color
        ),
      ),
    );
  }
}