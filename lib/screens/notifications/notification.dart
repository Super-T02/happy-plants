import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happy_plants/services/event.dart';
import 'package:happy_plants/services/garden.dart';
import 'package:happy_plants/services/plant.dart';
import 'package:happy_plants/shared/models/events.dart';
import 'package:happy_plants/shared/models/plant.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:happy_plants/shared/utilities/util.dart';
import 'package:happy_plants/shared/widgets/util/custom_button.dart';
import 'package:happy_plants/shared/widgets/util/lists/custom_list_group.dart';
import 'package:happy_plants/shared/widgets/util/lists/custom_list_row.dart';
import 'package:provider/provider.dart';

import '../../shared/models/garden.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, this.eventId, this.nextDate}) : super(key: key);

  static const String routeName = '/notification';
  final String? eventId;
  final DateTime? nextDate;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  EventsModel? event;
  Plant? plant;
  Garden? garden;
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

    // Get doc snapshot of the plant
    DocumentSnapshot plantDoc = await PlantService.getPlantSnapshot(
        localEvent.plantId,
        localEvent.gardenId,
        user.uid
    );

    // Generate garden and plant
    Garden localGarden = await GardenService.getGarden(localEvent.gardenId, user);
    Plant localPlant = Plant.mapFirebaseDocToPlant(plantDoc, localEvent.gardenId);

    setState(() {
      event = localEvent;
      plant = localPlant;
      garden = localGarden;
      loading = false;
    });

    Util.endLoading();
  }

  /// Handles the submit
  Future<void> onSubmit(CustomUser user) async {
    try {
      Util.startLoading();
      await EventService.patchEvent(event!.id!, 'lastDate', DateTime.now(), user);
      Util.endLoading();
      Navigator.of(context).pop();
    } catch (e) {
      // TODO
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    final theme = Theme.of(context);

    if(!loading!) {
      Icon eventIcon = Icon(
        EventTypesHelper.getIconDataFromEventType(event!.type),
        color: theme.textTheme.bodyText1!.color,
      );

      // Event related information
      List<Widget> relatedInformation = [];
      String? lastDateString = Util.getStringFromDateTime(event!.lastDate);
      lastDateString ??= 'Not Known';
      DateTime nextDate = event!.getNextDate();

      // Choose the right extra information
      switch(event!.type){
        case EventTypes.watering:
          Watering data = event?.data as Watering;
          relatedInformation = [
            CustomListRow(
              title: 'Water amount',
              data: '${data.waterAmount} ml',
            ),
            CustomListRow(
              title: 'Interval',
              data: PeriodsHelper.getStringFromPeriod(data.interval),
            ),
            CustomListRow(
              title: 'Next Date',
              data: PeriodsHelper.getNiceDateWording(nextDate),
            ),
            CustomListRow(
              title: 'Last Date',
              data: lastDateString,
            ),
          ];
          break;
        case EventTypes.spray:
          IntervalDateTime data = event?.data as IntervalDateTime;
          relatedInformation = [
            CustomListRow(
              title: 'Interval',
              data: PeriodsHelper.getStringFromPeriod(data.interval),
            ),
            CustomListRow(
              title: 'Next Date',
              data: PeriodsHelper.getNiceDateWording(nextDate),
            ),
            CustomListRow(
              title: 'Last Date',
              data: lastDateString,
            ),
          ];
          break;
        case EventTypes.fertilize:
          Fertilize data = event?.data as Fertilize;
          relatedInformation = [
            CustomListRow(
              title: 'Fertilizer Amount',
              data: '${data.amount} mg',
            ),
            CustomListRow(
              title: 'Interval',
              data: PeriodsHelper.getStringFromPeriod(data.interval),
            ),
            CustomListRow(
              title: 'Next Date',
              data: PeriodsHelper.getNiceDateWording(nextDate),
            ),
            CustomListRow(
              title: 'Last Date',
              data: lastDateString,
            ),
          ];
          break;
        case EventTypes.repot:
          IntervalDateTime data = event?.data as IntervalDateTime;
          relatedInformation = [
            CustomListRow(
              title: 'Interval',
              data: PeriodsHelper.getStringFromPeriod(data.interval),
            ),
            CustomListRow(
              title: 'Next Date',
              data: PeriodsHelper.getNiceDateWording(nextDate),
            ),
            CustomListRow(
              title: 'Last Date',
              data: lastDateString,
            ),
          ];
          break;
        case EventTypes.dustOff:
          IntervalDateTime data = event?.data as IntervalDateTime;
          relatedInformation = [
            CustomListRow(
              title: 'Interval',
              data: PeriodsHelper.getStringFromPeriod(data.interval),
            ),
            CustomListRow(
              title: 'Next Date',
              data: PeriodsHelper.getNiceDateWording(nextDate),
            ),
            CustomListRow(
              title: 'Last Date',
              data: lastDateString,
            ),
          ];
          break;
      }


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
            CustomListGroup(
                title: 'Informations',
                children: <Widget>[
                  CustomListRow(
                    title: 'Garden',
                    data:  garden!.name,
                  ),
                  CustomListRow(
                    title: 'Plant',
                    data: plant!.name,
                  ),
                  CustomListRow(
                    title: 'Upcoming Event',
                    data: EventTypesHelper.getStringFromEventType(event!.type),
                  ),
            ]),
            CustomListGroup(
                title: 'Event Information',
                children: relatedInformation
            ),
            CustomButton(
              onTap: () => onSubmit(user!),
              text: 'Done',
              isPrimary: true,
              iconData: Icons.check,
            ),
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