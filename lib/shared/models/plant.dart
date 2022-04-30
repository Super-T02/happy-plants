import '../utilities/sizes.dart';
import 'events.dart';

/// Data structure for a plant
class Plant extends JSON{

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
  List<String>? eventIds;

  static checkItemName(iconName){
    if(allFiles.contains(iconName)){
      return true;
    }
    else{
      return false;
    }
  }

  @override
  Map<String, dynamic> toJSON() {
    return {
      'gardenId': gardenID,
      'id': id,
      'dustOff': dustOff?.toJSON(),
      'fertilize': fertilize?.toJSON(),
      'icon': icon,
      'name': name,
      'plantSize': plantSize?.toJSON(),
      'potSize': SizeHelper.getStringFromSize(potSize),
      'repot': repot?.toJSON(),
      'spray': spray?.toJSON(),
      'sunDemand': SizeHelper.getStringFromSize(sunDemand),
      'temperature': temperature,
      'type': type,
      'watering': watering?.toJSON(),
      'eventIds': eventIds,
    };
  }

}

/// IntervalDateTime for a given interval and Date
class IntervalDateTime extends JSON{
  IntervalDateTime({this.interval, this.startDate});

  Periods? interval; // in days
  DateTime? startDate;

  @override
  Map<String, dynamic> toJSON(){
    return {
      "interval": interval?.index,
      "startDate": startDate,
    };
  }
}

class Fertilize extends IntervalDateTime{
  Fertilize({interval, startDate, this.amount})
      : super(interval: interval, startDate: startDate);

  int? amount; // in

  @override
  Map<String, dynamic> toJSON(){
    return {
      "amount": amount,
      "interval": interval?.index,
      "startDate": startDate,
    };
  }
}

class Watering extends IntervalDateTime{
  Watering({interval, startDate, this.waterAmount})
      : super(interval: interval, startDate: startDate);

  int? waterAmount; // in ml

  @override
  Map<String, dynamic> toJSON(){
    return {
      "waterAmount":waterAmount,
      "interval": interval?.index,
      "startDate": startDate,
    };
  }
}

class PlantSize extends JSON{
  PlantSize({this.begin, this.now});

  int? begin;
  int? now;

  @override
  Map<String, dynamic> toJSON(){
    return {
      "begin": begin,
      "now": now,
    };
  }
}

class AddPlant extends JSON{
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

  @override
  Map<String, dynamic> toJSON() {
    return {
      'gardenId': gardenID,
      'dustOff': dustOff?.toJSON(),
      'fertilize': fertilize?.toJSON(),
      'icon': icon,
      'name': name,
      'plantSize': plantSize?.toJSON(),
      'potSize': SizeHelper.getStringFromSize(potSize),
      'repot': repot?.toJSON(),
      'spray': spray?.toJSON(),
      'sunDemand': SizeHelper.getStringFromSize(sunDemand),
      'temperature': temperature,
      'type': type,
      'watering': watering?.toJSON(),
    };
  }
}


abstract class JSON {
  Map<String, dynamic> toJSON();
}