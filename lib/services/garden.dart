import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:happy_plants/services/event.dart';
import 'package:happy_plants/shared/models/garden.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:happy_plants/shared/utilities/util.dart';

import '../config.dart';
import '../shared/models/events.dart';
import '../shared/models/notification.dart';

class GardenService {

  /// Adds a new garden
  static Future<void> addGarden(AddGarden newGarden, CustomUser user) {
    dynamic result;

    try{
      Util.startLoading();

      CollectionReference gardens = getGardenCollectionRef(user);
      result = gardens.add({
        'icon': newGarden.icon,
        'name': newGarden.name
      });

    } finally {
      Util.endLoading();
    }

    return result;
  }

  /// Updates a garden based on its gardenID
  static Future<void> patchGarden(String gardenID, String fieldName, dynamic updatedValue, CustomUser user) {
    dynamic result;

    try{
      Util.startLoading();

      DocumentReference garden = getGardenDocRef(gardenID, user);
      result = garden.update({
        fieldName: updatedValue
      });

    } finally {
      Util.endLoading();
    }

    return result;
  }

  /// Deletes a garden based on its gardenID
  static Future<void> deleteGarden(String gardenID, CustomUser user) {
    dynamic result;

    try{
      Util.startLoading();

      CollectionReference events = EventService.getEventsCollectionRef(user);

      // Delete all events
      events.where('gardenId', isEqualTo: gardenID).get().then((QuerySnapshot querySnapshot) async {
        for (DocumentSnapshot event in querySnapshot.docs) {
          await EventService.deleteEvent(event.id, user);
        }

        await notificationService.cancelAllNotifications();
        await EventService.scheduleAllNotifications(user);
      });

      DocumentReference garden = getGardenDocRef(gardenID, user);
      result = garden.delete();

    } finally {
      Util.endLoading();
    }

    return result;
  }

  /// Get the ref on a garden instance based on the user and garden id
  static DocumentReference getGardenDocRef(String gardenID, CustomUser user) {
    return FirebaseFirestore.instance
        .collection('users').doc(user.uid)
        .collection('gardens').doc(gardenID);
  }

  /// Get the ref on the garden collection based on the user id
  static CollectionReference getGardenCollectionRef(CustomUser user) {
    return FirebaseFirestore.instance
        .collection('users').doc(user.uid)
        .collection('gardens');
  }

  /// Generates a snapshot stream of the garden instances
  static Stream<QuerySnapshot> gardenStream(CustomUser user) {
    return FirebaseFirestore.instance
        .collection('users').doc(user.uid)
        .collection('gardens')
        .snapshots();
  }
}