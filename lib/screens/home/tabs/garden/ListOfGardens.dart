import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happy_plants/services/garden.dart';
import 'package:happy_plants/shared/models/garden.dart';
import '../../../../shared/models/user.dart';
import '../../../../shared/widgets/garden/garden_widget.dart';
import 'package:provider/provider.dart';

/// Widget for getting all available garden for a specific user and display them
class ListOfGardens extends StatefulWidget {
  const ListOfGardens({Key? key}) : super(key: key);

  @override
  State<ListOfGardens> createState() => _ListOfGardensState();
}

class _ListOfGardensState extends State<ListOfGardens> {
  @override
  Widget build(BuildContext context) {
    // Get user of context
    final user = Provider.of<CustomUser?>(context)!;

    // Get the current data stream for the authenticated user
    final Stream<QuerySnapshot> _gardenStream = GardenService.gardenStream(user);


    // Build the stream
    return StreamBuilder<QuerySnapshot>(
      stream: _gardenStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // Has errors
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        // Waiting for the answer
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Document does not exist");
        }

        // Widget to be returned if the request was successful
        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          padding: const EdgeInsets.all(25),
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return GardenSingle(garden: Garden(name: data['name'], icon: data['icon']));
          }).toList(),
        );
      },
    );

  }
}
