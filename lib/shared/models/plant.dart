import 'package:cloud_firestore/cloud_firestore.dart';

import '../../screens/home/tabs/garden/plants/plant_card.dart';
import '../utilities/sizes.dart';
import 'events.dart';

/// Data structure for a plant
class Plant extends JSON {
  static final List<String> allFiles = [
    'bogenhanf',
    'bonsai',
    'cactus',
    'dragon_tree',
    'houseleek',
    'ivy',
    'palm',
    'peace_lily',
    'scandens'
  ];
  // Constructor
  Plant(
      {required this.gardenID,
      required this.id,
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
      this.eventIds});

  // Required
  String id;
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
  List<dynamic>? eventIds;

  static checkItemName(iconName) {
    if (allFiles.contains(iconName)) {
      return true;
    } else {
      return false;
    }
  }

  static Plant mapFirebaseDocToPlant(
      DocumentSnapshot snapshot, String gardenID) {
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;

    PlantSize plantSize = PlantSize();
    Watering watering = Watering();
    IntervalDateTime spray = IntervalDateTime();
    Fertilize fertilize = Fertilize();
    IntervalDateTime repot = IntervalDateTime();
    IntervalDateTime dustOff = IntervalDateTime();
    List events = [];

    if (data['plantSize'] != null) {
      plantSize.now = data['plantSize']['now'];
      plantSize.begin = data['plantSize']['begin'];
    }

    if (data['watering'] != null && data['watering']['interval'] != null) {
      watering.waterAmount = data['watering']['waterAmount'];
      watering.interval = Periods.values[data['watering']['interval']];
      watering.startDate = data['watering']['startDate']?.toDate();
    }

    if (data['spray'] != null && data['spray']['interval'] != null) {
      spray.interval = Periods.values[data['spray']['interval']];
      spray.startDate = data['spray']['startDate']?.toDate();
    }

    if (data['fertilize'] != null && data['fertilize']['interval'] != null) {
      fertilize.amount = data['fertilize']['amount'];
      fertilize.interval = Periods.values[data['fertilize']['interval']];
      fertilize.startDate = data['fertilize']['startDate']?.toDate();
    }

    if (data['repot'] != null && data['repot']['interval'] != null) {
      repot.interval = Periods.values[data['repot']['interval']];
      repot.startDate = data['repot']['startDate']?.toDate();
    }

    if (data['dustOff'] != null && data['dustOff']['interval'] != null) {
      dustOff.interval = Periods.values[data['dustOff']['interval']];
      dustOff.startDate = data['dustOff']['startDate']?.toDate();
    }

    if (data['events'] != null) {
      events = data['events'] as List<dynamic>;
    }

    Plant plant = Plant(
        name: data['name'],
        icon: data['icon'],
        id: snapshot.id,
        type: data['type'],
        plantSize: plantSize,
        potSize: SizeHelper.getSizeFromString(data['potSize']),
        watering: watering,
        spray: spray,
        fertilize: fertilize,
        temperature: data['temperature'],
        sunDemand: SizeHelper.getSizeFromString(data['sunDemand']),
        repot: repot,
        dustOff: dustOff,
        eventIds: events,
        gardenID: gardenID);

    return plant;
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
class IntervalDateTime extends JSON {
  IntervalDateTime({this.interval, this.startDate});

  Periods? interval; // in days
  DateTime? startDate;

  @override
  Map<String, dynamic> toJSON() {
    return {
      "interval": interval?.index,
      "startDate": startDate,
    };
  }
}

class Fertilize extends IntervalDateTime {
  Fertilize({Periods? interval, DateTime? startDate, this.amount})
      : super(interval: interval, startDate: startDate);

  int? amount; // in

  @override
  Map<String, dynamic> toJSON() {
    return {
      "amount": amount,
      "interval": interval?.index,
      "startDate": startDate,
    };
  }
}

class Watering extends IntervalDateTime {
  Watering({Periods? interval, DateTime? startDate, this.waterAmount})
      : super(interval: interval, startDate: startDate);

  int? waterAmount; // in ml

  @override
  Map<String, dynamic> toJSON() {
    return {
      "waterAmount": waterAmount,
      "interval": interval?.index,
      "startDate": startDate,
    };
  }
}

class PlantSize extends JSON {
  PlantSize({this.begin, this.now});

  int? begin;
  int? now;

  @override
  Map<String, dynamic> toJSON() {
    return {
      "begin": begin,
      "now": now,
    };
  }
}

class AddPlant extends JSON {
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
