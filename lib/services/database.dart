// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  void insertIntoDatabase() {
    FirebaseFirestore.instance
        .collection("/Clubs/Creative Arts/Heads")
        .add({"Name": "Srivani Reddy"})
        .then((value) => {print("User with id is inserted")})
        .catchError((onError) {
          print(onError);
        });
  }

  Stream getHeads(String clubName) {
    return FirebaseFirestore.instance
        .collection("/Clubs/Creative Arts/Heads")
        .snapshots();
  }
}
