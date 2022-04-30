import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:happy_plants/shared/models/plant.dart';

/// Events model for saved events
///
/// Params:
///   - String? id: Id of the event set after generation in the backend
///   - String userId: The id of the user the event is related to
///   - String plantId: The id of the plant the event is related to
///   - EventTypes type: Type of the event
///   - Periods period: Time Period for the event
///   - Plant plant: Plant related to the event
///   - T Data: The data for the event
///   - DateTime startDate:  Start date of the event | For the single type it is the next date
class EventsModel<T extends JSON> {
  String? id;
  String userId;
  String plantId;
  String gardenId;
  EventTypes type;
  Periods period;
  T data;
  DateTime startDate;

  EventsModel({
     required this.userId,
     required this.plantId,
     required this.gardenId,
     required this.type,
     required this.period,
     required this.data,
     required this.startDate,
  });

  Map<String, dynamic> toJSON() {
    return {
      'plantId': plantId,
      'gardenId': gardenId,
      'type': type.index,
      'period': period.index,
      'data': data.toJSON(),
      'startDate': startDate,
    };
  }

  /// Returns the body string for the event type
  /// Params:
  ///  - name: Name of the plant
  ///  - number: is required for watering or fertilize
  String? getNotificationBodyPartFromType(String name, int? number) {
    switch(type) {
      case EventTypes.watering: return '$name need $number! ml to drink!';
      case EventTypes.spray: return 'Spray $name to make the plant happy!';
      case EventTypes.fertilize: return 'Give $name $number mg fertilizer to make the plant strong!';
      case EventTypes.repot: return 'Please give the plant a new pot';
      case EventTypes.dustOff: return 'Please dust the plant off';
      default: return null;
    }
  }


  /// Returns the title string for the event type
  /// Params:
  ///  - name: Name of the plant
  String? getNotificationTitlePartFromType(String name) {
    switch(type) {
      case EventTypes.watering: return '$name is thirsty!';
      case EventTypes.spray: return '$name is dry!';
      case EventTypes.fertilize: return '$name needs some power!';
      case EventTypes.repot: return '$name has no space!';
      case EventTypes.dustOff: return '$name cannot breath!';
      default: return null;
    }
  }
}

/// Event Types
enum EventTypes {
  watering,
  spray,
  fertilize,
  repot,
  dustOff
}

/// Period Types
enum Periods {
  single,
  daily,
  monthly,
  weekly,
  yearly,
}

class PeriodsHelper {
  static List<String> periodsMenuItems = ['single', 'daily', 'monthly', 'weekly', 'yearly'];

  static Periods? getPeriodsFromString(String? text){
    switch(text) {
      case 'single': return Periods.single;
      case 'daily': return Periods.daily;
      case 'monthly': return Periods.monthly;
      case 'weekly': return Periods.weekly;
      case 'yearly': return Periods.yearly;
      default: return null;
    }
  }

  static String? getStringFromPeriod(Periods? period){
    switch(period) {
      case Periods.single: return 'single';
      case Periods.daily: return 'daily';
      case Periods.monthly: return 'monthly';
      case Periods.weekly: return 'weekly';
      case Periods.yearly: return 'yearly';
      default: return null;
    }
  }

  static DateTimeComponents? getDateTimeComponentsFromPeriod(Periods? period){
    switch(period) {
      case Periods.daily: return DateTimeComponents.time;
      case Periods.monthly: return DateTimeComponents.dayOfMonthAndTime;
      case Periods.weekly: return DateTimeComponents.dayOfWeekAndTime;
      case Periods.yearly: return DateTimeComponents.dateAndTime;
      default: return null;
    }
  }
}