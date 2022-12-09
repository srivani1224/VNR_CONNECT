import 'package:cloud_firestore/cloud_firestore.dart';

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
}
