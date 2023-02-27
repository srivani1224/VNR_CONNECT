// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: prefer_const_constructors, file_names, use_build_context_synchronously, must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:vnr_connect/screens/editevent.dart';
import 'package:vnr_connect/screens/login_form.dart';
import 'package:vnr_connect/services/authenticate.dart';

class EventDetails extends StatefulWidget {
 final List<dynamic> alldocs;
 DocumentSnapshot doc ;
 EventDetails({super.key,required this.alldocs,required this.doc});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
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
        setState(() {
           canPerformAction =  widget.alldocs.contains(user.uid);
        });
    }
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Event 1"),
      actions: [
          TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.logout),
            label: const Text("Logout"),
            onPressed: () async {
              await AuthService().signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginForm()),
                  (Route route) => false);
            },
          ),
          canPerformAction?TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (
                (context) => EditEvent())));
          }, icon: Icon(Icons.edit), label: Text("Edit"),):Container(),
        ],),
    body:Center(child: Text(widget.doc['eventName']),)
    );
  }
}