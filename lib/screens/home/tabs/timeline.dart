import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
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
  // Images
  final lightImage = "assets/images/LightEventEmpty.svg";
  final darkImage = "assets/images/DarkEventEmpty.svg";

  List<CustomListGroup>? children;
  bool? timeout;
  String? timeoutString;

  @override
  initState() {
    children = [];
    timeout = false;
    timeoutString = 'Server timed out, please try it later again';
    super.initState();
  }

  /// Generates a stream of all list components
  Future<List<CustomListGroup?>> _getListGroup(CustomUser? user) async {
    List<EventWithPlantAndGarden?> eventList =
        await EventService.getUserEventsList(user);

    if (eventList.isNotEmpty) {
      DateTime now = DateTime.now();
      List<CustomListGroup?> listGroup = [];
      Map<String, List<CustomListTile>> childrenLocal = {};

      // Sorts the event list
      eventList.sort((a, b) => EventsModel.sort(a, b));

      for (EventWithPlantAndGarden? event in eventList) {
        DateTime nextDate = event!.event.getNextDate();
        String wording = PeriodsHelper.getNiceDateWording(nextDate);
        // Add list tiles
        if (!childrenLocal.containsKey(wording)) {
          // Date doesn't exist

          // If the event is already done today
          if (event.event.lastDate?.year == now.year &&
              event.event.lastDate?.month == now.month &&
              event.event.lastDate?.day == now.day) {
            childrenLocal[wording] = [
              CustomListTile(
                textDecoration: TextDecoration.lineThrough,
                title: event.plant.name,
                subtitle:
                    EventTypesHelper.getStringFromEventType(event.event.type),
                leading: Icons.check,
                onTap: () async {
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NotificationScreen(
                            eventId: event.event.id,
                            nextDate: nextDate,
                          )));

                  if (mounted) {
                    setState(() {
                      children = [];
                      timeout = false;
                      timeoutString =
                          'Server timed out, please try it later again';
                    });
                  }
                },
              ),
            ];
          } else {
            childrenLocal[wording] = [
              CustomListTile(
                title: event.plant.name,
                subtitle:
                    EventTypesHelper.getStringFromEventType(event.event.type),
                leading:
                    EventTypesHelper.getIconDataFromEventType(event.event.type),
                onTap: () async {
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NotificationScreen(
                            eventId: event.event.id,
                            nextDate: nextDate,
                          )));

                  if (mounted) {
                    setState(() {
                      children = [];
                      timeout = false;
                      timeoutString =
                          'Server timed out, please try it later again';
                    });
                  }
                },
              )
            ];
          }
        } else {
          // Date already exist

          // If the event is already done today
          if (event.event.lastDate?.year == now.year &&
              event.event.lastDate?.month == now.month &&
              event.event.lastDate?.day == now.day) {
            childrenLocal[wording]!.add(CustomListTile(
              textDecoration: TextDecoration.lineThrough,
              title: event.plant.name,
              subtitle:
                  EventTypesHelper.getStringFromEventType(event.event.type),
              leading: Icons.check,
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NotificationScreen(
                          eventId: event.event.id,
                          nextDate: nextDate,
                        )));

                if (mounted) {
                  setState(() {
                    children = [];
                    timeout = false;
                    timeoutString =
                        'Server timed out, please try it later again';
                  });
                }
              },
            ));
          } else {
            childrenLocal[wording]!.add(CustomListTile(
              title: event.plant.name,
              subtitle:
                  EventTypesHelper.getStringFromEventType(event.event.type),
              leading:
                  EventTypesHelper.getIconDataFromEventType(event.event.type),
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NotificationScreen(
                          eventId: event.event.id,
                          nextDate: nextDate,
                        )));

                Future.delayed(Duration.zero, () {
                  if (mounted) {
                    setState(() {
                      children = [];
                      timeout = false;
                      timeoutString =
                          'Server timed out, please try it later again';
                    });
                  }
                });
              },
            ));
          }
        }
      }

      childrenLocal.forEach((dateString, children) {
        listGroup.add(CustomListGroup(title: dateString, children: children));
      });

      return listGroup;
    }

    return [];
  }

  @override
  void dispose() {
    children = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DbUser?>(context);
    final darkMode = Theme.of(context).brightness;
    final ThemeData theme = Theme.of(context);

    if (children!.isEmpty) {
      // Listen to the group stream
      _getListGroup(user).then((list) {
        if (list.isNotEmpty && children!.isEmpty) {
          List<CustomListGroup> listGroup = [];

          for (CustomListGroup? group in list) {
            if (group != null) {
              listGroup.add(group);
            }
          }
          if (mounted) {
            setState(() {
              children = listGroup;
              timeout = false;
              timeoutString = 'Server timed out, please try it later again';
            });
          }
        } else if (list.isEmpty) {
          if (mounted) {
            setState(() {
              timeoutString = 'You have no event yet :(';
              timeout = true;
            });
          }
        }
      });
    }

    if (user != null && children != null && children!.isNotEmpty) {
      return ListView(
        children: children!,
      );
    } else if (timeout!) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            timeoutString!,
            style: theme.textTheme.headline3!,
          ),
          const SizedBox(
            height: 32.0,
          ),
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.8,
            child: SvgPicture.asset(
                darkMode == Brightness.dark ? darkImage : lightImage),
          ),
        ],
      );
    } else {
      Future.delayed(const Duration(seconds: 15), () {
        if (children != null && children!.isEmpty) {
          if (mounted) {
            setState(() {
              timeout = true;
              timeoutString = 'Server timed out, please try it later again';
            });
          }
        }
      });
      return const SpinKitFadingCircle(color: AppColors.accent1);
    }
  }
}
