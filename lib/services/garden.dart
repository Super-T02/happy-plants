import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:happy_plants/shared/models/garden.dart';
import 'package:happy_plants/shared/models/user.dart';

class GardenService {

  /// Adds a new garden
  static Future<void> addGarden(Garden newGarden, CustomUser user) {
    CollectionReference gardens = getGardenCollectionRef(user);

    return gardens.add({
      'icon': newGarden.icon,
      'name': newGarden.name
    }).catchError((error) => {
      // TODO: Error handling
    });
  }

  /// Updates a garden based on its gardenID
  static Future<void> patchGarden(String gardenID, String fieldName, dynamic updatedValue, CustomUser user) {
    DocumentReference garden = getGardenDocRef(gardenID, user);

    return garden.update({
      fieldName: updatedValue
    }).catchError((error) => {
      // TODO: Error handling
    });
  }

  /// Deletes a garden based on its gardenID
  static Future<void> deleteGarden(String gardenID, CustomUser user) {
    DocumentReference garden = getGardenDocRef(gardenID, user);

    return garden.delete().catchError((error) => {
      // TODO: Error handling
    });
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