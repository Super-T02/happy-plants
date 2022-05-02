import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happy_plants/services/garden.dart';
import 'package:happy_plants/shared/models/garden.dart';
import 'package:happy_plants/shared/widgets/util/custom_button.dart';
import '../../../../shared/models/user.dart';
import '../../../../shared/widgets/garden/garden_card.dart';
import 'package:provider/provider.dart';

/// Widget for getting all available garden for a specific user and display them
class ListOfGardens extends StatefulWidget {
  const ListOfGardens({Key? key}) : super(key: key);

  @override
  State<ListOfGardens> createState() => _ListOfGardensState();
}

class _ListOfGardensState extends State<ListOfGardens> {
  // Images
  final lightImage = "assets/images/LightGardenEmpty.svg";
  final darkImage = "assets/images/DarkGardenEmpty.svg";

  @override
  Widget build(BuildContext context) {
    // Get user of context
    final user = Provider.of<CustomUser?>(context)!;
    final darkMode = Theme.of(context).brightness;
    final theme = Theme.of(context);

    // Get the current data stream for the authenticated user
    final Stream<QuerySnapshot> _gardenStream = GardenService.gardenStream(user);

    Widget widget;


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

        // Display empty text or not
        if(snapshot.data!.docs.isEmpty){
          widget = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                'You have no garden yet :(',
                style: theme.textTheme.headline3!,
              ),
              const SizedBox(height: 32.0,),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width * 0.8,
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.09),
                child: SvgPicture.asset(darkMode == Brightness.dark? darkImage : lightImage),
              ),
              const SizedBox(height: 32.0,),
              CustomButton(
                onTap: () {
                  Navigator.of(context).pushNamed('/newGarden');
                },
                text: 'Create your first garden!',
                isPrimary: true,
                iconData: Icons.create_outlined,
              )
            ],
          );

        } else {
          widget = Expanded(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(15), //padding from screen to widget
                addAutomaticKeepAlives: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  return GardenSingle(garden: Garden(name: data['name'], icon: data['icon'], id: document.id));
                }).toList(),
              )
          );
        }

        // Widget to be returned if the request was successful
        return widget;
      },
    );
  }
}
