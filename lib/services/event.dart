import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happy_plants/services/garden.dart';
import 'package:happy_plants/services/notification.dart';
import 'package:happy_plants/services/plant.dart';
import 'package:happy_plants/shared/models/events.dart';
import 'package:happy_plants/shared/models/notification.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:happy_plants/shared/utilities/util.dart';

import '../shared/models/garden.dart';
import '../shared/models/plant.dart';

class EventService {
  static final NotificationService notificationService = NotificationService();


  /// Adds a new event
  static Future<DocumentReference> addEvent(EventsModel newEvent, CustomUser user) async {
    DocumentReference result;


    try {
      Util.startLoading();

      CollectionReference events = getEventsCollectionRef(user);
      result = await events.add(newEvent.toJSON());

      // Get notification
      ScheduledNotificationModel notification = await notificationService.getScheduledNotificationFromEvent(newEvent);

      // Schedule notification
      notificationService.scheduledNotificationRepeat(notification);

    } finally {
      Util.endLoading();
    }

    return result;
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

    return result;
  }

  /// Schedules all events for the given user
  static Future<void> scheduleAllNotifications(CustomUser? user) async{
    if(user != null) {
      CollectionReference events = EventService.getEventsCollectionRef(user);

      events.get().then((QuerySnapshot querySnapshot) async {
        for (DocumentSnapshot event in querySnapshot.docs) {

          // Get the mapped model
          EventsModel newEvent = EventsModel.mapFirebaseDocToEvent(user.uid, event);

          if(newEvent.startDate.isAfter(DateTime.now()) || newEvent.period != Periods.single){
            // Get notification
            ScheduledNotificationModel notification = await notificationService.getScheduledNotificationFromEvent(newEvent);

            // Schedule notification
            notificationService.scheduledNotificationRepeat(notification);
          }
        }
      });
    }
  }

  /// Gets all the events of a user as a stream
  static Future<List<EventWithPlantAndGarden?>> getUserEventsList(CustomUser? user) async {

    if(user == null) {
      return [];
    }

    CollectionReference events = EventService.getEventsCollectionRef(user);

    return events.orderBy('startDate').snapshots().asyncMap((data) async {
      List<EventWithPlantAndGarden?> eventsList = [];

      for (DocumentSnapshot event in data.docs) {

        // Get the mapped model
        EventsModel newEvent = EventsModel.mapFirebaseDocToEvent(user.uid, event);

        // Get Plant
        DocumentSnapshot plantSnapshot = await PlantService.getPlantSnapshot(newEvent.plantId, newEvent.gardenId, user.uid);
        Plant plant = Plant.mapFirebaseDocToPlant(plantSnapshot, newEvent.gardenId);

        // Get garden
        Garden garden = await GardenService.getGarden(newEvent.gardenId, user);

        EventWithPlantAndGarden finalEvent = EventWithPlantAndGarden(event: newEvent, plant: plant, garden: garden);

        // Add event to list
        eventsList.add(finalEvent);
      }

      return eventsList;
    }).first;
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