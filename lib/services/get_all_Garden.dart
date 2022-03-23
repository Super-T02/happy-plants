import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetAllGarden extends StatefulWidget {
  const GetAllGarden({Key? key, required this.userID}) : super(key: key);
  final String userID;

  @override
  State<GetAllGarden> createState() => _GetAllGardenState();
}

class _GetAllGardenState extends State<GetAllGarden> {
  @override
  Widget build(BuildContext context) {
    // Get the current data stream for the authenticated user
    final Stream<QuerySnapshot> _gardenStream = FirebaseFirestore.instance
        .collection('users').doc(widget.userID)
        .collection('garden')
        .snapshots();

    // Build the stream
    return StreamBuilder<QuerySnapshot>(
      stream: _gardenStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Document does not exist");
        }

        return Column(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String,
                dynamic>;
            return Text('${data['name']}'); // TODO: Replace with Garden Widget!
          }).toList(),
        );
      },
    );
  }
}
