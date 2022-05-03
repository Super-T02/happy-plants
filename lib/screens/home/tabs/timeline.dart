import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:happy_plants/screens/notifications/notification.dart';
import 'package:happy_plants/services/event.dart';
import 'package:happy_plants/shared/models/events.dart';
import 'package:happy_plants/shared/utilities/app_colors.dart';
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


  /// Generates a stream of all list components
  Future<List<CustomListGroup?>> _getListGroup(CustomUser? user) async {
    List<EventWithPlantAndGarden?> eventList
      = await EventService.getUserEventsList(user);


    if(eventList.isNotEmpty){
      List<CustomListGroup?> listGroup = [];
      Map<String, List<CustomListTile>> children = {};

      // Sorts the event list
      eventList.sort((a, b) => EventsModel.sort(a, b));

      for(EventWithPlantAndGarden? event in eventList){
        DateTime nextDate = event!.event.getNextDate();
        String wording = PeriodsHelper.getNiceDateWording(nextDate);

        // Add list tiles
        if(!children.containsKey(wording)) { // Date doesn't exist
          children[wording] = [
            CustomListTile(
              title: event.plant.name,
              subtitle: EventTypesHelper.getStringFromEventType(event.event.type),
              leading: EventTypesHelper.getIconDataFromEventType(event.event.type),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationScreen(eventId: event.event.id))),
            )
          ];

        } else { // Date already exist
          children[wording]!.add(
              CustomListTile(
                title: event.plant.name,
                subtitle: EventTypesHelper.getStringFromEventType(event.event.type),
                leading: EventTypesHelper.getIconDataFromEventType(event.event.type),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationScreen(eventId: event.event.id))),
              )
          );
        }
      }

      children.forEach((dateString, children) {
        listGroup.add(CustomListGroup(title: dateString, children: children));
      });

      return listGroup;
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DbUser?>(context);

    // Listen to the group stream
    _getListGroup(user).then((list) {
      if(list.isNotEmpty && children!.isEmpty) {
        List<CustomListGroup> listGroup = [];

        for(CustomListGroup? group in list) {
          if(group != null) {
            listGroup.add(group);
          }
        }

        setState(() {
          children = listGroup;
        });
      }
    });


    if(user != null && children != null && children!.isNotEmpty) {
      return ListView(
        children: children!,
      );
    } else {
      return const SpinKitFadingCircle(color: AppColors.accent1);
    }
  }
}