import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:happy_plants/services/event.dart';
import 'package:happy_plants/shared/models/events.dart';
import 'package:happy_plants/shared/widgets/util/lists/custom_list_group.dart';
import 'package:happy_plants/shared/widgets/util/lists/custom_list_tile.dart';
import 'package:provider/provider.dart';

import '../../../shared/models/user.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<CustomListGroup>? children;

  @override
  initState(){
    children = [];
    super.initState();
  }

  Future<Stream<List<CustomListGroup?>>> _getListGroup(CustomUser? user) async {
    Stream<List<EventWithPlantAndGarden?>> eventStream
      = await EventService.getUserEventsStream(user);

    return eventStream.map((events) {
      List<CustomListGroup?> listGroup = [];

      if(events.isNotEmpty){

        Map<DateTime, List<CustomListTile>> children = {};
        
        for(EventWithPlantAndGarden? event in events){

          // Add list tiles
          if(!children.containsKey(event!.event.startDate)) { // Date doesn't exist

            children[event.event.startDate] = [
              CustomListTile(
                title: event.plant.name,
                subtitle: 'Watering', // TODO map
              )
            ];

          } else { // Date already exist

            children[event.event.startDate]!.add(
                CustomListTile(
                  title: event.plant.name,
                  subtitle: 'Watering', // TODO map
                )
            );
          }
        }

        children.forEach((date, children) {
          listGroup.add(CustomListGroup(title: date.toString(), children: children));
        });

        return listGroup;
      }

      return [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DbUser?>(context);

    // Listen to the group stream
    _getListGroup(user).then((stream) => stream.listen((value) {
      if(value.isNotEmpty) {
        List<CustomListGroup> listGroup = [];

        for(CustomListGroup? group in value) {
          if(group != null) {
            listGroup.add(group);
          }
        }

        setState(() {
          children = listGroup;
        });
      }
    }));

    if(user != null && children != null && children!.isNotEmpty) {
      return ListView(
        children: children!,
      );
    } else {
      return const SpinKitFadingCircle(color: Colors.white);
    }
  }
}