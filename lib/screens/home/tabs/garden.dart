import 'package:flutter/material.dart';
import 'package:happy_plants/screens/home/tabs/garden/ListOfGardens.dart';
import 'package:provider/provider.dart';
import '../../../shared/models/user.dart';

class Garden extends StatefulWidget {
  const Garden({Key? key}) : super(key: key);

  @override
  State<Garden> createState() => _GardenState();
}

class _GardenState extends State<Garden> {


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context)!;

    return Scaffold(
      body: Column(
        children: const <Widget>[
          ListOfGardens(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('floating action button was clicked!')));
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