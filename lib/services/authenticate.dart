
// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';





class AuthService{

//Registeration of new user using email and password
String name="";
String email="";
Future<bool> registerWithEmailAndPass(registerName,registerEmail,registerPassword) async{
  name=registerName;
  email=registerEmail;

  try {
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: registerEmail,
    password: registerPassword
  );

//User? user = FirebaseAuth.instance.currentUser;
//       String? uid = user?.uid;
// final FirebaseAuth auth = FirebaseAuth.instance;
// User? user = auth.currentUser;
//       await user!.reload();
User? user = FirebaseAuth.instance.currentUser;
  print(userCredential);
  String userId= user==null?user!.uid:"";
 
return true;

} on 
FirebaseAuthException
 catch (e)
 {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
    return false;
  }
   else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
    return false;
  }
}
 catch (e) {
  print(e);
  return false;
}


return false;

}

Future<bool> addUser() async{
  User? user = FirebaseAuth.instance.currentUser;
    String userId = user == null ? user!.uid : "";
  await FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .set({
      'Name': name,
      "EmailAddress": email,
      "Batch": "2019-2023",
      "UserId": userId,
      'Branch': "",
      "followers": [],
      "following": [],
      "registeredEvents": [],
      "registeredClubs": [],
      "profileImage":
          "https://static.vecteezy.com/system/resources/previews/005/544/718/original/profile-icon-design-free-vector.jpg"
    });
return true;

}


Future<bool> signInWithEmailAndPassword(email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print(userCredential.user!.email);

      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

 Future<void> signOut() async{
  await FirebaseAuth.instance.signOut();
 }


}


