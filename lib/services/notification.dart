import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:happy_plants/services/plant.dart';
import 'package:happy_plants/services/shared_preferences_controller.dart';
import 'package:happy_plants/shared/models/events.dart';
import 'package:happy_plants/shared/models/notification.dart';
import 'package:timezone/timezone.dart';
import '../config.dart';
import '../main.dart';

class NotificationService {
  final scheduledChanelId = 'scheduled-notification';
  final scheduledChanelName = 'Scheduled Notifications';
  final scheduledChanelDescription = 'Notifications scheduled for a period of time';

  /// Shows a normal notification
  Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('your channel id', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');

    const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }

  Future<void> checkPendingNotificationRequests(context) async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
    await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content:
        Text('${pendingNotificationRequests.length} pending notification '
            'requests'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }



  /// Schedules a notification for a defined period of time
  Future<void> scheduledNotificationRepeat(ScheduledNotificationModel notification) async {
    if(SharedPreferencesController.getNotificationTimeStatus()){

      await flutterLocalNotificationsPlugin.zonedSchedule(
          notificationNextId,
          notification.title,
          notification.body,
          _nextInstanceNotificationTime(notification.startTimeStamp),

          // Setting the notification details
          NotificationDetails(
            android: AndroidNotificationDetails(
              scheduledChanelId,
              scheduledChanelName,
              importance: Importance.high,
              priority: Priority.high,
              channelDescription: scheduledChanelDescription,
            ),
          ),

          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: notification.dateTimeComponent,
          payload: notification.eventId,
      );

      notificationNextId ++;
      SharedPreferencesController.setNotificationNextId(notificationNextId);
    }
  }


  /// Cancels all notifications
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    SharedPreferencesController.setNotificationNextId(0);
  }


  /// Returns the next notification time base on the periodDay, and the option lastTime Stamp
  /// Needs:
  ///   - DateTime? lastTimeStamp:  (Optional) DateTime when the last event was triggered, if null it will be the current timestamp
  ///
  /// Returns:
  ///   - TZDateTime for the next schedule
  TZDateTime _nextInstanceNotificationTime(DateTime? lastTimeStamp) {
    TZDateTime planned;
    TimeOfDay defaultTime = SharedPreferencesController.getCurrentNotificationTime();

    // Select the last time stamp
    if(lastTimeStamp != null) {
      planned = TZDateTime.from(lastTimeStamp, local);

    }  else {
      planned = TZDateTime.now(local);
    }

    // Get the next scheduled date
    TZDateTime scheduledDate = TZDateTime(
        local,
        planned.year,
        planned.month,
        planned.day,
        defaultTime.hour,
        defaultTime.minute
    );

    return scheduledDate;
  }

  Future<ScheduledNotificationModel> getScheduledNotificationFromEvent(EventsModel event) async {

    // Receive document data
    DocumentSnapshot snapshot = await PlantService.getPlantSnapshot(
        event.plantId,
        event.gardenId,
        event.userId
    );
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    String name = data['name'];
    int? amount;

    // add amount
    if(event.type == EventTypes.watering) {

      amount = data['watering']['waterAmount'];

    } else if (event.type == EventTypes.fertilize) {

      amount = data['fertilize']['amount'];

    }

    // generate notification
    ScheduledNotificationModel notification = ScheduledNotificationModel(
        eventId: event.id,
        title: event.getNotificationTitlePartFromType(name)!,
        body: event.getNotificationBodyPartFromType(name, amount)!,
        dateTimeComponent: PeriodsHelper.getDateTimeComponentsFromPeriod(event.period),
        startTimeStamp: event.startDate
    );

    return notification;
  }
}