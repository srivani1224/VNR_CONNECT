// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/events.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/heads.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/view_member.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/joining_requests.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Members extends StatefulWidget {
  final String path;
  const Members(this.path, {super.key});

  @override
  MembersState createState() => MembersState();
}

class MembersState extends State<Members> {
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
        stream: FirebaseFirestore.instance
            .collection(path + "/Members")
            .snapshots(),
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
                                ViewMember(path, snapshot.data!.docs[index])),
                      );
                    },
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                color: Colors.lightBlueAccent,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                height: 100,
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
                                          builder: (context) => ViewMember(path,
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
                              Container(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.lightBlueAccent,
                                  ),
                                  onPressed: null,
                                  child: Text(
                                    "Remove",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
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
