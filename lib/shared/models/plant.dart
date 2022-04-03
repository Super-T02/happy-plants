import '../utilities/sizes.dart';

// Data structure for a plant
class Plant{
  // Constructor
  Plant({
    required this.gardenID,
    required this.name,
    this.watering,
    this.plantSize,
    this.fertilize,
    this.dustOff,
    this.icon,
    this.potSize,
    this.repot,
    this.spray,
    this.sunDemand,
    this.temperature,
    this.type
  });

  // Required
  String gardenID;
  String name;

  // Not required
  IntervalDateTime? dustOff;
  Fertilize? fertilize;
  IntervalDateTime? repot;
  IntervalDateTime? spray;
  String? icon;
  PlantSize? plantSize;
  Sizes? potSize;
  Sizes? sunDemand;
  int? temperature;
  String? type;
  Watering? watering;
}

class IntervalDateTime{
  IntervalDateTime({required this.interval, required this.lastTime});

  int interval; // in days
  DateTime lastTime;
}

class Fertilize extends IntervalDateTime{
  Fertilize({required interval, required lastTime, required this.amount})
      : super(interval: interval, lastTime: lastTime);

  int amount; // in
}

class Watering extends IntervalDateTime{
  Watering({required int interval, required DateTime lastTime, required this.waterAmount})
      : super(interval: interval, lastTime: lastTime);

  int waterAmount; // in ml
}

class PlantSize{
  PlantSize({required this.begin, required this.now});

  int begin;
  int now;
}