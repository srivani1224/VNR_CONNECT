import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditEvent extends StatefulWidget {
  const EditEvent({super.key});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {

  bool canPerformAction = false;

  @override
  void initState() {
    super.initState();
    checkUserPermission();
  }

   void checkUserPermission() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get();
      if (snapshot.exists) {
        setState(() {
           canPerformAction = true;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Event"),
      actions: [
        canPerformAction?TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (
                (context) => const EditEvent())));
          }, icon: const Icon(Icons.edit), label: const Text("Edit"),):Container(),
          TextButton.icon(
            style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
            onPressed: (){}, icon: const Icon(Icons.logout
          ), label: const Text("Logout"))
          ],),
    );
  }
}