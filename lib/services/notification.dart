import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:happy_plants/shared/models/notification.dart';
import 'package:timezone/data/latest_all.dart';
import 'package:timezone/timezone.dart';
import '../main.dart';

class NotificationService {
  final scheduledChanelId = 'scheduled-notification';
  final scheduledChanelName = 'Scheduled Notifications';
  final scheduledChanelDescription = 'Notifications scheduled for a period of time';

  // Shows a normal notification
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


  /// Schedules a notification for a defined period of time
  Future<void> _scheduledNotification(ScheduledNotificationModel notification) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        notification.title,
        notification.body,
        _nextInstanceNotificationTime(notification.periodDays, notification.lastTimeStamp),

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
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime
    );
  }


  /// Returns the next notification time base on the periodDay, and the option lastTime Stamp
  /// Needs:
  ///   - int periodDays:           Period of time until the next event should be triggered
  ///   - DateTime? lastTimeStamp:  (Optional) DateTime when the last event was triggered, if null it will be the current timestamp
  ///
  /// Returns:
  ///   - TZDateTime for the next schedule
  TZDateTime _nextInstanceNotificationTime(int periodDays, DateTime? lastTimeStamp) {
    TZDateTime planned;


    // Select the last time stamp
    if(lastTimeStamp != null) {
      planned = TZDateTime.from(lastTimeStamp, local);

    }  else {
      planned = TZDateTime.now(local);
    }

    // Get the next scheduled date
    TZDateTime scheduledDate = TZDateTime(local, planned.year, planned.month, planned.day, 10);

    // Add the period until the next date is in the future
    do{
      scheduledDate = scheduledDate.add(Duration(days: periodDays));
    } while (scheduledDate.isBefore(planned));

    return scheduledDate;
  }
}