import '../utilities/sizes.dart';

// Data structure for a plant
class Plant{

  static final List<String> allFiles = ['bogenhanf','bonsai','cactus','dragon_tree','houseleek','ivy','palm','peace_lily','scandens'];
  // Constructor
  Plant({
    required this.gardenID,
    required this.id,
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
  String id;
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

  static checkItemName(iconName){
    if(allFiles.contains(iconName)){
      return true;
    }
    else{
      return false;
    }
  }

}


class IntervalDateTime{
  IntervalDateTime({this.interval, this.lastTime});

  int? interval; // in days
  DateTime? lastTime;

  Map toJSON(){
    return {
      "interval":interval,
      "lastTime":lastTime,
    };
  }
}

class Fertilize extends IntervalDateTime{
  Fertilize({interval, lastTime, this.amount})
      : super(interval: interval, lastTime: lastTime);

  int? amount; // in

  @override
  Map toJSON(){
    return {
      "amount": amount,
      "interval":interval,
      "lastTime":lastTime,
    };
  }
}

class Watering extends IntervalDateTime{
  Watering({interval, lastTime, this.waterAmount})
      : super(interval: interval, lastTime: lastTime);

  int? waterAmount; // in ml

  @override
  Map toJSON(){
    return {
      "waterAmount":waterAmount,
      "interval":interval,
      "lastTime":lastTime,
    };
  }
}

class PlantSize{
  PlantSize({this.begin, this.now});

  int? begin;
  int? now;

  Map toJSON(){
    return {
      "begin": begin,
      "now": now,
    };
  }
}

class AddPlant{
  // Constructor
  AddPlant({
    required this.gardenID,
    required this.name,
    required this.type,
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
  });

  // Required
  String gardenID;
  String name;
  String type;

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
  Watering? watering;
}