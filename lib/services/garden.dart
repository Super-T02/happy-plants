import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:happy_plants/shared/models/garden.dart';
import 'package:happy_plants/shared/models/user.dart';

class GardenService {
  static Future<void> addGarden(Garden newGarden, CustomUser user){


    CollectionReference gardens
    = FirebaseFirestore.instance
        .collection('users').doc(user.uid)
        .collection('gardens');

    return gardens.add({
      'icon': newGarden.icon,
      'name': newGarden.name
    });
  }


}