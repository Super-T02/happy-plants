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

    return Column(
      children: const <Widget>[
        ListOfGardens(),
      ],
    );
  }
}