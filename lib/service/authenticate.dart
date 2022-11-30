
// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';





class AuthService{

//Registeration of new user using email and password
Future<bool> registerWithEmailAndPass(registerEmail,registerPassword) async{

  try {
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: registerEmail,
    password: registerPassword
  );

 

  print(userCredential);

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




}


