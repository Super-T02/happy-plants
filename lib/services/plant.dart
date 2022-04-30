import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:happy_plants/shared/models/plant.dart';
import 'package:happy_plants/shared/models/user.dart';
import '../shared/utilities/sizes.dart';

class PlantService {

  /// Adds a new plant
  static Future<void> addPlant( AddPlant newPlant, CustomUser user) {
    CollectionReference plants = getPlantsCollectionRef(user, newPlant.gardenID);

    dynamic dustOff, fertilize, plantSize, repot, spray, watering;

    if(newPlant.dustOff != null){
      dustOff = newPlant.dustOff;
    }
    if(newPlant.fertilize != null){
      fertilize = newPlant.fertilize;
    }
    if(newPlant.plantSize != null){
      plantSize = newPlant.plantSize;
    }
    if(newPlant.repot != null){
      repot = newPlant.repot;
    }
    if(newPlant.spray != null){
      spray = newPlant.spray;
    }
    if(newPlant.watering != null){
      watering = newPlant.watering;
    }

    return plants.add({
      'dustOff': dustOff.toJSON(),
      'fertilize': fertilize.toJSON(),
      'icon': newPlant.icon,
      'name': newPlant.name,
      'plantSize': plantSize.toJSON(),
      'potSize': SizeHelper.getStringFromSize(newPlant.potSize),
      'repot': repot.toJSON(),
      'spray': spray.toJSON(),
      'sunDemand': SizeHelper.getStringFromSize(newPlant.sunDemand),
      'temperature': newPlant.temperature,
      'type': newPlant.type,
      'watering': watering.toJSON(),
    });

    // TODO: Error handling
  }

  /// Updates a plant based on its plant id
  static Future<void> putPlant(Plant updatedPlant, CustomUser user) {
    DocumentReference plant = getPlantDocRef(updatedPlant.id, updatedPlant.gardenID, user);

    dynamic dustOff, fertilize, plantSize, repot, spray, watering;

    if(updatedPlant.dustOff != null){
      dustOff = updatedPlant.dustOff;
    }
    if(updatedPlant.fertilize != null){
      fertilize = updatedPlant.fertilize;
    }
    if(updatedPlant.plantSize != null){
      plantSize = updatedPlant.plantSize;
    }
    if(updatedPlant.repot != null){
      repot = updatedPlant.repot;
    }
    if(updatedPlant.spray != null){
      spray = updatedPlant.spray;
    }
    if(updatedPlant.watering != null){
      watering = updatedPlant.watering;
    }

    return plant.set({
      'dustOff': dustOff,
      'fertilize': fertilize,
      'icon': updatedPlant.icon,
      'name': updatedPlant.name,
      'plantSize': plantSize.toJSON(),
      'potSize': updatedPlant.potSize,
      'repot': repot,
      'spray': spray,
      'sunDemand': updatedPlant.sunDemand,
      'temperature': updatedPlant.temperature,
      'type': updatedPlant.type,
      'watering': watering,
    });
    // TODO: Error handling
  }

  //TODO: ladebalken einfuegen

  /// Deletes a plants based on its plantId
  static Future<void> deletePlant(String plantId, String gardenID, CustomUser user) {
    DocumentReference plant = getPlantDocRef(plantId, gardenID, user);

    return plant.delete(); // TODO: Error handling
  }

  /// Get the ref on a garden instance based on the user, gardenId and plantId
  static DocumentReference getPlantDocRef(String plantId, String gardenID, CustomUser user) {
    return FirebaseFirestore.instance
        .collection('users').doc(user.uid)
        .collection('gardens').doc(gardenID)
        .collection('plants').doc(plantId);
  }

  /// Get the ref on the plants collection based on the user id and garden id
  static CollectionReference getPlantsCollectionRef(CustomUser user, String gardenId) {
    return FirebaseFirestore.instance
        .collection('users').doc(user.uid)
        .collection('gardens').doc(gardenId)
        .collection('plants');
  }

  /// Generates a snapshot stream of the plant instances
  static Stream<QuerySnapshot> plantStream(CustomUser user, String gardenId) {
    return FirebaseFirestore.instance
        .collection('users').doc(user.uid)
        .collection('gardens').doc(gardenId)
        .collection('plants')
        .snapshots();
  }
}