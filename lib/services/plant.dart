import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happy_plants/config.dart';
import 'package:happy_plants/services/event.dart';
import 'package:happy_plants/shared/models/events.dart';
import 'package:happy_plants/shared/models/plant.dart';
import 'package:happy_plants/shared/models/user.dart';
import '../shared/utilities/sizes.dart';
import '../shared/utilities/util.dart';

class PlantService {

  /// Adds a new plant
  static Future<void> addPlant( AddPlant newPlant, CustomUser user) async {
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

    DocumentReference addedPlant = await plants.add({
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

    await _addEventsAll(newPlant, user, addedPlant.id);

    // TODO: Error handling
  }

  /// Updates a plant based on its plant id
  static Future<void> putPlant(Plant updatedPlant, CustomUser user) async {
    DocumentReference plant = getPlantDocRef(updatedPlant.id, updatedPlant.gardenID, user.uid);

    notificationService.cancelAllNotifications();

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

    await plant.set({
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

    AddPlant newPlant = AddPlant(
      gardenID: updatedPlant.gardenID,
      name: updatedPlant.name,
      type: updatedPlant.type!,
      icon: updatedPlant.icon,
      dustOff: updatedPlant.dustOff,
      fertilize: updatedPlant.fertilize,
      plantSize: updatedPlant.plantSize,
      potSize: updatedPlant.potSize,
      repot: updatedPlant.repot,
      spray: updatedPlant.spray,
      sunDemand: updatedPlant.sunDemand,
      temperature: updatedPlant.temperature,
      watering: updatedPlant.watering,
    );

    await _addEventsAll(newPlant, user, updatedPlant.id);

    // TODO: Error handling
  }

  /// Updates a plant based on its gardenID and plantId
  /// WARNING: PATCH PLANT DOES NOT UPDATE THE NOTIFICATIONS!!!!!
  static Future<void> patchPlant(String gardenID, String plantId, String fieldName, dynamic updatedValue, CustomUser user) {
    dynamic result;

    try{
      Util.startLoading();

      DocumentReference plant = getPlantDocRef(plantId, gardenID, user.uid);
      result = plant.update({
        fieldName: updatedValue
      });

    } finally {
      Util.endLoading();
    }

    return result;
    // TODO: Error handling
  }

  //TODO: ladebalken einfuegen

  /// Deletes a plants based on its plantId
  static Future<void> deletePlant(Plant plant, String gardenID, CustomUser user) async {
    DocumentReference plantDoc = getPlantDocRef(plant.id, gardenID, user.uid);

    debugPrint(plant.eventIds.toString());

    if(plant.eventIds != null) {

      for (String eventId in plant.eventIds!) {
        await EventService.deleteEvent(eventId, user);
      }

      await notificationService.cancelAllNotifications();
      await EventService.scheduleAllNotifications(user);
    }

    return plantDoc.delete(); // TODO: Error handling
  }

  /// Get the ref on a garden instance based on the user, gardenId and plantId
  static DocumentReference getPlantDocRef(String plantId, String gardenID, String userId) {
    return FirebaseFirestore.instance
        .collection('users').doc(userId)
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

  /// Adds all events of a plant which aren't null
  static _addEventsAll(AddPlant plant, CustomUser user, plantId) async {
    List<String> eventIds = [];


    // Watering
    if(plant.watering != null){
      Watering watering = plant.watering!;

      if(watering.startDate != null && watering.interval != null) {
        debugPrint(watering.startDate.toString());
        DocumentReference event = await EventService.addEvent(
            EventsModel<Watering>(
              userId: user.uid,
              plantId: plantId,
              gardenId: plant.gardenID,
              type: EventTypes.watering,
              period: watering.interval!,
              data: watering,
              startDate: watering.startDate!,
            ),
            user
        );

        eventIds.add(event.id);
      }
    }

    // Spray
    if(plant.spray != null){
      IntervalDateTime spray = plant.spray!;

      if(spray.startDate != null && spray.interval != null) {
        DocumentReference event = await EventService.addEvent(
            EventsModel<IntervalDateTime>(
              userId: user.uid,
              plantId: plantId,
              gardenId: plant.gardenID,
              type: EventTypes.spray,
              period: spray.interval!,
              data: spray,
              startDate: spray.startDate!,
            ),
            user
        );


        eventIds.add(event.id);
      }
    }

    // Fertilize
    if(plant.fertilize != null){
      Fertilize fertilize = plant.fertilize!;

      if(fertilize.startDate != null && fertilize.interval != null) {
        DocumentReference event = await EventService.addEvent(
            EventsModel<Fertilize>(
              userId: user.uid,
              plantId: plantId,
              gardenId: plant.gardenID,
              type: EventTypes.fertilize,
              period: fertilize.interval!,
              data: fertilize,
              startDate: fertilize.startDate!,
            ),
            user
        );

        eventIds.add(event.id);
      }
    }

    // Repot
    if(plant.repot != null){
      IntervalDateTime repot = plant.repot!;

      if(repot.startDate != null && repot.interval != null) {
        DocumentReference event = await EventService.addEvent(
            EventsModel<IntervalDateTime>(
              userId: user.uid,
              plantId: plantId,
              gardenId: plant.gardenID,
              type: EventTypes.repot,
              period: repot.interval!,
              data: repot,
              startDate: repot.startDate!,
            ),
            user
        );

        eventIds.add(event.id);
      }
    }

    // DustOff
    if(plant.dustOff != null){
      IntervalDateTime dustOff = plant.dustOff!;

      if(dustOff.startDate != null && dustOff.interval != null) {
        DocumentReference event = await EventService.addEvent(
            EventsModel<IntervalDateTime>(
              userId: user.uid,
              plantId: plantId,
              gardenId: plant.gardenID,
              type: EventTypes.dustOff,
              period: dustOff.interval!,
              data: dustOff,
              startDate: dustOff.startDate!,
            ),
            user
        );

        eventIds.add(event.id);
      }
    }

    patchPlant(plant.gardenID, plantId, 'events', eventIds, user);
  }

  static Future<DocumentSnapshot> getPlantSnapshot(String plantId,String gardenID, String userId) {
    return getPlantDocRef(plantId, gardenID, userId).get();
  }
}