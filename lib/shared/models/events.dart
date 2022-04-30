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
class EventsModel {
  String? id;
  EventTypes type;
  Periods period;
  Plant plant;
  DateTime nextDate;
  DateTime? startDate;

  EventsModel({
     required this.type,
     required this.period,
     required this.plant,
     required this.nextDate,
     this.startDate
  });

  Map toJSON() {
    return {
      'type': type,
      'period': period,
      'plant': plant.toJSON(),
      'nextDate': nextDate,
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