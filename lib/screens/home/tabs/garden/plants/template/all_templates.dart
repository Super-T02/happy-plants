import '../../../../../../shared/models/events.dart';
import '../../../../../../shared/models/plant.dart';
import '../../../../../../shared/utilities/sizes.dart';

class Templates{
  static List<Plant> allTemplates = [];

  static getAllTemplates(String gardenID){
    List<Plant> allTemplates = [];
    //begin of templates
    //bonsai
    allTemplates.add(
        Plant(
          gardenID: gardenID,
          id: '',
          name: 'My Bonsai',
          type: 'Bonsai',
          icon: 'bonsai',
          watering: Watering(interval: PeriodsHelper.getPeriodsFromString('weekly'), startDate: DateTime.now(), waterAmount: 100),
          plantSize: PlantSize(begin: 20, now: 25),
          fertilize: Fertilize(interval: PeriodsHelper.getPeriodsFromString('monthly'), startDate: DateTime.now(), amount: 20),
          dustOff: IntervalDateTime(interval: PeriodsHelper.getPeriodsFromString('monthly'), startDate: DateTime.now()),
          potSize: SizeHelper.getSizeFromString('s'),
          repot: IntervalDateTime(interval: PeriodsHelper.getPeriodsFromString('yearly'), startDate: DateTime.now()),
          spray: IntervalDateTime(interval: PeriodsHelper.getPeriodsFromString('weekly'), startDate: DateTime.now()),
          sunDemand: SizeHelper.getSizeFromString('l'),
          temperature: 21,
        )
    );
    allTemplates.add(
        Plant(
          gardenID: gardenID,
          id: '',
          name: 'My Cactus',
          type: 'Cactus',
          icon: 'cactus',
          watering: Watering(interval: PeriodsHelper.getPeriodsFromString('monthly'), startDate: DateTime.now(), waterAmount: 100),
          plantSize: PlantSize(begin: 15, now: 18),
          fertilize: Fertilize(interval: PeriodsHelper.getPeriodsFromString('yearly'), startDate: DateTime.now(), amount: 30),
          dustOff: IntervalDateTime(interval: PeriodsHelper.getPeriodsFromString('yearly'), startDate: DateTime.now()),
          potSize: SizeHelper.getSizeFromString('s'),
          repot: IntervalDateTime(interval: PeriodsHelper.getPeriodsFromString('yearly'), startDate: DateTime.now()),
          spray: IntervalDateTime(interval: PeriodsHelper.getPeriodsFromString('monthly'), startDate: DateTime.now()),
          sunDemand: SizeHelper.getSizeFromString('xl'),
          temperature: 25,
        )
    );
    allTemplates.add(
        Plant(
          gardenID: gardenID,
          id: '',
          name: 'My Palm',
          type: 'Palm',
          icon: 'palm',
          watering: Watering(interval: PeriodsHelper.getPeriodsFromString('weekly'), startDate: DateTime.now(), waterAmount: 350),
          plantSize: PlantSize(begin: 50, now: 70),
          fertilize: Fertilize(interval: PeriodsHelper.getPeriodsFromString('monthly'), startDate: DateTime.now(), amount: 25),
          dustOff: IntervalDateTime(interval: PeriodsHelper.getPeriodsFromString('weekly'), startDate: DateTime.now()),
          potSize: SizeHelper.getSizeFromString('xl'),
          repot: IntervalDateTime(interval: PeriodsHelper.getPeriodsFromString('yearly'), startDate: DateTime.now()),
          spray: IntervalDateTime(interval: PeriodsHelper.getPeriodsFromString('weekly'), startDate: DateTime.now()),
          sunDemand: SizeHelper.getSizeFromString('l'),
          temperature: 23,
        )
    );
    return allTemplates;
  }
}