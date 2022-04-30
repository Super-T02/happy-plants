import 'package:happy_plants/shared/models/plant.dart';

/// Events model for saved events
///
/// Params:
///   - String? id: Id of the event set after generation in the backend
///   - EventTypes type: Type of the event
///   - Periods period: Time Period for the event
///   - Plant plant: Plant related to the event
///   - DateTime nextDate: Next time for the event
///   - DateTime? startDate: (optional) Start date of the event
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
}