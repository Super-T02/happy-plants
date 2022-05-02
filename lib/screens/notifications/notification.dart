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
    EventsModel event = EventsModel.mapFirebaseDocToEvent(user.uid, await eventRef.snapshots().first);

    DocumentSnapshot plantDoc = await PlantService.getPlantSnapshot(
        event.plantId,
        event.gardenId,
        user.uid
    );

    // TODO: When map plants exist

    setState(() {
      event = event;
      loading = false;
    });

    Util.endLoading();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);


    if(!loading!) {
      return Scaffold(
        appBar: AppBar(title: const Text('Test')),
        body: Text(widget.eventId!),
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