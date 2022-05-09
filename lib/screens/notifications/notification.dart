import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happy_plants/services/event.dart';
import 'package:happy_plants/services/plant.dart';
import 'package:happy_plants/shared/models/events.dart';
import 'package:happy_plants/shared/models/plant.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:happy_plants/shared/utilities/util.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, this.eventId}) : super(key: key);

  static const String routeName = '/notification';
  final String? eventId;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  EventsModel? event;
  Plant? plant;
  bool? loading;

  @override
  initState(){
    loading = true;
    super.initState();
  }

  /// Load the current event from the database
  Future<void> loadEvent(CustomUser user) async {
    Util.startLoading();
    DocumentReference eventRef = EventService.getEventDocRef(widget.eventId!, user);
    EventsModel localEvent = EventsModel.mapFirebaseDocToEvent(user.uid, await eventRef.snapshots().first);

    DocumentSnapshot plantDoc = await PlantService.getPlantSnapshot(
        localEvent.plantId,
        localEvent.gardenId,
        user.uid
    );

    Plant localPlant = Plant.mapFirebaseDocToPlant(plantDoc, localEvent.gardenId);

    setState(() {
      event = localEvent;
      plant = localPlant;
      loading = false;
    });

    Util.endLoading();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    final theme = Theme.of(context);

    Icon eventIcon = Icon(
      EventTypesHelper.getIconDataFromEventType(event!.type),
      color: theme.textTheme.bodyText1!.color,
    );

    if(!loading!) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: theme.textTheme.bodyText1!.color,
          ),
          title: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(plant!.name),
                const SizedBox(width: 16.0,),
                eventIcon
              ],
            ),
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(20), //padding from screen to widget
          addAutomaticKeepAlives: true,
          children: <Widget>[
            // Picture
            Card(
                semanticContainer: true,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)
                ),
                child: Container(
                  height: 200,
                  width: 200,

                  // Image for the background of the card
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/plant_backgrounds/${plant!.icon}.jpg'
                          ),
                          fit: BoxFit.cover
                      )
                  ),
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upcoming Event:',
                  style: theme.textTheme.headline3,
                ),
                Row(
                  children: <Widget>[
                    eventIcon,
                    Text(
                      '${EventTypesHelper.getStringFromEventType(event!.type)}',
                      style: theme.textTheme.headline3,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      );

    } else {

      Future.delayed(Duration.zero,() {
        if(user != null){
          loadEvent(user);
        }
      });

      return Container();
    }
  }
}