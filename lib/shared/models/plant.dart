import 'package:cloud_firestore/cloud_firestore.dart';

import '../../screens/home/tabs/garden/plants/plant_card.dart';
import '../utilities/sizes.dart';

// Data structure for a plant
class Plant{

  static final List<String> allFiles = ['bogenhanf','bonsai','cactus','dragon_tree','houseleek','ivy','palm','peace_lily','scandens'];
  // Constructor
  Plant({
    required this.gardenID,
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
    this.temperature
  });

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

  static checkItemName(iconName){
    if(allFiles.contains(iconName)){
      return true;
    }
    else{
      return false;
    }
  }

  static Plant mapFirebaseDocToPlant(DocumentSnapshot snapshot, String gardenID){
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;

    PlantSize plantSize = PlantSize();
    Watering watering = Watering();
    IntervalDateTime spray = IntervalDateTime();
    Fertilize fertilize = Fertilize();
    IntervalDateTime repot = IntervalDateTime();
    IntervalDateTime dustOff = IntervalDateTime();


    if(data['plantSize'] != null){
      plantSize.now = data['plantSize']['now'];
      plantSize.begin = data['plantSize']['begin'];
    }

    if(data['watering'] != null){
      watering.waterAmount = data['watering']['waterAmount'];
      watering.interval = data['watering']['interval']; //TODO: edit (edit after event merge)
      watering.lastTime = data['watering']['lastTime']?.toDate(); //TODO: lasttime to startdate
    }

    if(data['spray'] != null){
      spray.interval = data['spray']['interval']; //TODO: edit (edit after event merge)
      spray.lastTime = data['spray']['lastTime']?.toDate();//TODO: lasttime to startdate
    }

    if(data['fertilize'] != null){
      fertilize.amount = data['fertilize']['amount'];
      fertilize.interval = data['fertilize']['interval']; //TODO: edit (edit after event merge)
      fertilize.lastTime = data['fertilize']['lastTime']?.toDate();//TODO: lasttime to startdate
    }

    if(data['repot'] != null){
      repot.interval = data['repot']['interval']; //TODO: edit (edit after event merge)
      repot.lastTime = data['repot']['lastTime']?.toDate();//TODO: lasttime to startdate
    }

    if(data['dustOff'] != null){
      dustOff.interval = data['dustOff']['interval']; //TODO: edit (edit after event merge)
      dustOff.lastTime = data['dustOff']['lastTime']?.toDate();//TODO: lasttime to startdate
    }

    Plant plant = Plant(name: data['name'],
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
        gardenID: gardenID);

    return plant;
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
