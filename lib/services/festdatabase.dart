// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vnr_connect/models/events_model.dart';

class FestDB{

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Event>> getAllDocs(collectionName) async {

    List<Event> allEvents=[];
    
    db.collection(collectionName).get().then((QuerySnapshot qs) =>{
      qs.docs.forEach((element) {
       Event currentEvent = Event(name: element['eventName'],imageUrl: element['eventImageUrls'][0]);
       allEvents.add(currentEvent);
      })
    } );


    return allEvents;

  }
}