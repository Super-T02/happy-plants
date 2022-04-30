import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Model for the scheduled notifications
///
/// Parameters:
///   - String title:             Title of the notification
///   - String body:              Body of the notification
///   - DateTimeComponents? dateTimeComponent: (Optional) Repeat when fitting schema
///   - DateTime? startTimeStamp: (Optional) DateTime when the last event was triggered, if null it will be the current timestamp
class ScheduledNotificationModel{
  String title;
  String body;
  DateTimeComponents? dateTimeComponent;
  DateTime? startTimeStamp;

  ScheduledNotificationModel({
    required this.title,
    required this.body,
    this.dateTimeComponent,
    this.startTimeStamp
  });
}