/// Model for the scheduled notifications
///
/// Parameters:
///   - String title:             Title of the notification
///   - String body:              Body of the notification
///   - int periodDays:           Period of time in days when the notification should be triggered
///   - DateTime? lastTimeStamp: (Optional) DateTime when the last event was triggered, if null it will be the current timestamp
class ScheduledNotificationModel{
  String title;
  String body;
  int periodDays;
  DateTime? lastTimeStamp;

  ScheduledNotificationModel({
    required this.title,
    required this.body,
    required this.periodDays,
    this.lastTimeStamp
  });
}