import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Model for the scheduled notifications
///
/// Parameters:
///   - String title:             Title of the notification
///   - String body:              Body of the notification
///   - int periodDays:           Period of time in days when the notification should be triggered
///   - DateTimeComponents? dateTimeComponent: (Optional) Repeat when fitting schema
///   - DateTime? lastTimeStamp: (Optional) DateTime when the last event was triggered, if null it will be the current timestamp
class ScheduledNotificationModel{
  String title;
  String body;
  int periodDays;
  DateTimeComponents? dateTimeComponent;
  DateTime? lastTimeStamp;

  ScheduledNotificationModel({
    required this.title,
    required this.body,
    required this.periodDays,
    this.dateTimeComponent,
    this.lastTimeStamp
  });
}