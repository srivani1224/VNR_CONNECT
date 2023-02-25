// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vnr_connect/models/heads_model.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/events.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_vnr_student/home_clubs.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/desc.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/past_events.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/joining_requests.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/members.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/view_head.dart';
import 'package:vnr_connect/services/database.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Heads extends StatefulWidget {
  final String path;
  const Heads(this.path, {super.key});

  @override
  HeadsState createState() => HeadsState();
}

class HeadsState extends State<Heads> {
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
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection("$path/Heads").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ViewHead(path, snapshot.data!.docs[index])),
                      );
                    },
                    child: Center(
                      child: Container(
                        color: Colors.lightBlueAccent,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                color: Colors.lightBlueAccent,
                                child: Center(
                                    child: Text(snapshot.data!.docs[index]
                                        .get('Name'))),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.lightBlueAccent,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ViewHead(path,
                                              snapshot.data!.docs[index])),
                                    );
                                  },
                                  child: Text(
                                    "View",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
