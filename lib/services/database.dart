// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vnr_connect/models/heads_model.dart';

class DataBase {
  void insertDataIntoDatabase() {
    FirebaseFirestore.instance
        .collection("/Clubs/Creative Arts/Heads")
        .add({"Name": "Srivani Reddy"})
        .then((value) => {print("User with id is inserted")})
        .catchError((onError) {
          print(onError);
        });
  }

  Future<int> countHeads(String clubName) {
    return FirebaseFirestore.instance
        .collection("/Clubs/Creative Arts/Heads")
        .snapshots()
        .length;
  }

  Stream<List<Head>> getHeads(String clubName) {
    return FirebaseFirestore.instance
        .collection("/Clubs/Creative Arts/Heads")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Head.fromJson(doc.data())).toList());
  }
}
