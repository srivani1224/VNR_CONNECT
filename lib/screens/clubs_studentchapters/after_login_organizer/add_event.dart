// ignore_for_file: prefer_const_constructors, avoid_print, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/events.dart';

import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/past_events.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/heads.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/joining_requests.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/members.dart';

class AddEvent extends StatefulWidget {
  final String path;
  const AddEvent(this.path, {super.key});

  @override
  AddEventState createState() => AddEventState();
}

class AddEventState extends State<AddEvent> {
  final _addEventFormHeadKey = GlobalKey<FormState>();
  String get path => widget.path;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.lightBlueAccent,
            title: const Text('VNR CONNECT'),
            centerTitle: true,
            actions: [
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                icon: Icon(Icons.logout),
                label: Text("Logout"),
                onPressed: () {},
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                icon: Icon(Icons.person),
                label: Text("Profile"),
                onPressed: () {},
              ),
            ]),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: const Text('Events'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Events(path)),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.train,
                ),
                title: const Text('Heads'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Heads(path)),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.train,
                ),
                title: const Text('Members'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Members(path)),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.train,
                ),
                title: const Text('Joining Requests'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => JoiningRequests(path)),
                  );
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(50, 30, 50, 30),
          child: Form(
            key: _addEventFormHeadKey,
            child: Column(children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'About Event'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Timings'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Venue'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Members_In_Team'),
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Registration_Fee'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Guests'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Winners'),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                  onPressed: null,
                  child: Text(
                    "save",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}
