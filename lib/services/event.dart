import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:happy_plants/shared/models/events.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:happy_plants/shared/utilities/util.dart';

class EventService {

  /// Adds a new event
  static Future<void> addEvent(EventsModel newEvent, CustomUser user) {
    dynamic result;

    try{
      Util.startLoading();

      CollectionReference events = getEventsCollectionRef(user);
      result = events.add(newEvent.toJSON());

    } finally {
      Util.endLoading();
    }

    return result;


    // TODO: Error handling
  }

  /// Updates a event based on its eventID
  static Future<void> patchEvent(String eventID, String fieldName, dynamic updatedValue, CustomUser user) {
    dynamic result;

    try{
      Util.startLoading();

      DocumentReference event = getEventDocRef(eventID, user);
      result = event.update({
        fieldName: updatedValue
      });

    } finally {
      Util.endLoading();
    }

    return result;
    // TODO: Error handling
  }

  /// Deletes a event based on its eventId
  static Future<void> deleteEvent(String eventId, CustomUser user) {
    dynamic result;

    try{
      Util.startLoading();

      DocumentReference event = getEventDocRef(eventId, user);
      result = event.delete();

    } finally {
      Util.endLoading();
    }

    return result; // TODO: Error handling
  }

  /// Get the ref on a event instance based on the user and event id
  static DocumentReference getEventDocRef(String eventId, CustomUser user) {
    return FirebaseFirestore.instance
        .collection('users').doc(user.uid)
        .collection('events').doc(eventId);
  }

  /// Get the ref on the event collection based on the event id
  static CollectionReference getEventsCollectionRef(CustomUser user) {
    return FirebaseFirestore.instance
        .collection('users').doc(user.uid)
        .collection('events');
  }

  /// Generates a snapshot stream of the event instances
  static Stream<QuerySnapshot> eventStream(CustomUser user) {
    return FirebaseFirestore.instance
        .collection('users').doc(user.uid)
        .collection('events')
        .snapshots();
  }
}