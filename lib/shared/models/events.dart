import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:happy_plants/shared/models/garden.dart';
import 'package:happy_plants/shared/models/plant.dart';
import 'package:quiver/time.dart';

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
     this.id,
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

  /// Maps a fire base doc reference of a event to a event model
  static EventsModel mapFirebaseDocToEvent(String userId, DocumentSnapshot documentSnapshot){
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    EventTypes type = EventTypes.values[data['type']];
    Periods period = Periods.values[data['period']];

    EventsModel newEvent;

    switch(type){
      case EventTypes.watering:
        newEvent = EventsModel(
          id: documentSnapshot.id,
          userId: userId,
          plantId: data['plantId'],
          gardenId: data['gardenId'],
          type: type,
          period: period,
          data: Watering(
              interval: period,
              startDate: data['data']['startDate'].toDate(),
              waterAmount: data['data']['waterAmount'],
          ),
          startDate: data['startDate'].toDate()
        );
        break;
      case EventTypes.dustOff:
      case EventTypes.repot:
      case EventTypes.spray:
        newEvent = EventsModel(
          id: documentSnapshot.id,
          userId: userId,
          plantId: data['plantId'],
          gardenId: data['gardenId'],
          type: type,
          period: period,
          data: IntervalDateTime(
            interval: period,
            startDate: data['data']['startDate'].toDate(),
          ),
          startDate: data['startDate'].toDate()
        );
        break;
      case EventTypes.fertilize:
        newEvent = EventsModel(
          id: documentSnapshot.id,
          userId: userId,
          plantId: data['plantId'],
          gardenId: data['gardenId'],
          type: type,
          period: period,
          data: Fertilize(
            interval: period,
            startDate: data['data']['startDate'].toDate(),
            amount: data['data']['amount'],
          ),
          startDate: data['startDate'].toDate()
        );
        break;
      default:
        throw Exception('No valid Events loaded');
    }

    return newEvent;
  }

  /// Get the next event date
  DateTime getNextDate() {
    switch (period) {
      case Periods.single:
        return startDate;
      case Periods.daily:
        return _getDaily();
      case Periods.monthly:
        return _getMonthly();
      case Periods.weekly:
        return _getWeekly();
      case Periods.yearly:
        return _getYearly();
    }
  }

  /// Get the daily date
  DateTime _getDaily() {
    DateTime date = startDate;

    while(date.isBefore(DateTime.now().subtract(aDay))) {
      date = date.add(aDay);
    }

    return date;
  }

  /// Get the monthly date
  DateTime _getMonthly() {
    DateTime date = startDate;

    // Add days of the month to date
    while(date.isBefore(DateTime.now().subtract(aDay))) {
      Duration duration = Duration(days: daysInMonth(date.year, date.month));
      date = date.add(duration);
    }

    // If month has less days
    while(date.day > daysInMonth(date.year, date.month)){
      date = date.subtract(aDay);
    }

    return date;
  }

  /// Get the yearly date
  DateTime _getYearly() {
    DateTime date = startDate;

    while(date.isBefore(DateTime.now().subtract(aDay))) {
      date = DateTime(date.year + 1, date.month, date.day);
    }

    // If month has less days (only february)
    while(date.day > daysInMonth(date.year, date.month)){
      date = date.subtract(aDay);
    }

    return date;
  }

  /// Get the weekly date
  DateTime _getWeekly() {
    DateTime date = startDate;

    while(date.isBefore(DateTime.now().subtract(aDay))) {
      date = date.add(aWeek);
    }

    return date;
  }

  static int sort(event, nextEvent) {
    DateTime nextDateEvent = event!.event.getNextDate();
    DateTime nextDateNextEvent = nextEvent!.event.getNextDate();

    if(nextDateEvent.isBefore(nextDateNextEvent)){
      return -1;
    } else if (nextDateEvent.isAtSameMomentAs(nextDateNextEvent)){
      return 0;
    } else {
      return 1;
    }
  }
}

/// Class for having a event with the related plant and garden
class EventWithPlantAndGarden{
  EventsModel event;
  Plant plant;
  Garden garden;

  EventWithPlantAndGarden({
    required this.event,
    required this.plant,
    required this.garden
  });
}

/// Event Types
enum EventTypes {
  watering,
  spray,
  fertilize,
  repot,
  dustOff
}

/// Mapping and helper class for event types
class EventTypesHelper {
  static EventTypes? getEventTypeFromString(String? text){
    switch(text?.toLowerCase()) {
      case 'watering': return EventTypes.watering;
      case 'spray': return EventTypes.spray;
      case 'fertilize': return EventTypes.fertilize;
      case 'repot': return EventTypes.repot;
      case 'dust off': return EventTypes.dustOff;
      default: return null;
    }
  }

  static String? getStringFromEventType(EventTypes? eventType){
    switch(eventType) {
      case EventTypes.watering: return 'Watering';
      case EventTypes.spray: return 'Spray';
      case EventTypes.fertilize: return 'Fertilize';
      case EventTypes.repot: return 'Repot';
      case EventTypes.dustOff: return 'Dust off';
      default: return null;
    }
  }

  static IconData? getIconDataFromEventType(EventTypes? eventType){
    switch(eventType) {
      case EventTypes.watering: return Icons.water_drop;
      case EventTypes.spray: return FontAwesome5.spray_can;
      case EventTypes.fertilize: return FontAwesome5.poo;
      case EventTypes.repot: return FontAwesome5.exchange_alt;
      case EventTypes.dustOff: return FontAwesome5.paint_brush;
      default: return null;
    }
  }
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
  static List<String> periodsMenuItems = ['single', 'daily', 'weekly', 'monthly', 'yearly'];

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

  /// Generates the date string in the following format
  ///
  /// Tue, 22.05.2022
  static String getNiceDateWording(DateTime time){
    int dayNow = DateTime.now().day;
    int monthNow = DateTime.now().month;
    int yearNow = DateTime.now().year;
    String weekDay = _getDayOfWeekAsString(time);;

    if(time.month == monthNow && time.year == yearNow){
      // Same Day
      if(time.day == dayNow){
        weekDay = 'Today';
      }

      // Tomorrow
      if(time.day == DateTime.now().add(aDay).day){
        weekDay = 'Tomorrow';
      }
    }

    String month;
    if(time.month < 10){
      month = '0${time.month}';
    } else {
      month = time.month.toString();
    }

    String day;
    if(time.day < 10){
      day = '0${time.day}';
    } else {
      day = time.day.toString();
    }

    return '$weekDay, $day.$month.${time.year}';
  }

  /// Returns the day of the week as string
  static String _getDayOfWeekAsString(DateTime time){
    switch(time.weekday){
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thr';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        throw Exception('Invalid weekday ${time.weekday}');
    }
  }
}