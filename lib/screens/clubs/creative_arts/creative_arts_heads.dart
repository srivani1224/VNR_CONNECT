// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vnr_connect/screens/clubs/creative_arts/creative_arts_events.dart';
import 'package:vnr_connect/screens/clubs/creative_arts/creative_arts_joining_requests.dart';
import 'package:vnr_connect/screens/clubs/creative_arts/creative_arts_members.dart';
import 'package:vnr_connect/services/database.dart';

class CreativeArtsHeads extends StatefulWidget {
  const CreativeArtsHeads({super.key});

  @override
  CreativeArtsHeadsState createState() => CreativeArtsHeadsState();
}

class CreativeArtsHeadsState extends State<CreativeArtsHeads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  MaterialPageRoute(
                      builder: (context) => const CreativeArtsEvents()),
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
                  MaterialPageRoute(
                      builder: (context) => const CreativeArtsHeads()),
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
                  MaterialPageRoute(
                      builder: (context) => const CreativeArtsMembers()),
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
                      builder: (context) =>
                          const CreativeArtsJoiningRequests()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          DataBase().insertDataIntoDatabase();
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.lightBlueAccent,
        ),
        child: const Text("Explore"),
      )),
    );
  }
}
