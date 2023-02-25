// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vnr_connect/models/heads_model.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/add_event.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/edit_event.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/future_events.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/heads.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/ongoing_events.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/view_event.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/view_joining_requests.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_vnr_student/home_clubs.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/desc.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/past_events.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/joining_requests.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/members.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/view_head.dart';
import 'package:vnr_connect/services/database.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Events extends StatefulWidget {
  final String path;
  const Events(this.path, {super.key});

  @override
  EventsState createState() => EventsState();
}

class EventsState extends State<Events> {
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
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PastEvents(path)),
                    );
                  },
                  child: Card(
                      color: Colors.lightBlueAccent,
                      margin: EdgeInsets.all(20),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 40),
                        child: Text("Past Events"),
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OngoingEvents(path)),
                    );
                  },
                  child: Card(
                      color: Colors.lightBlueAccent,
                      margin: EdgeInsets.all(20),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 90, vertical: 40),
                        child: Text("Ongoing Events"),
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FutureEvents(path)),
                    );
                  },
                  child: Card(
                      color: Colors.lightBlueAccent,
                      margin: EdgeInsets.all(20),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 127, vertical: 40),
                        child: Text("Upcoming Events"),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
