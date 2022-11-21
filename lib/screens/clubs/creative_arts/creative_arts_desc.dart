// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vnr_connect/screens/clubs/creative_arts/creative_arts_events.dart';
import 'package:vnr_connect/screens/clubs/creative_arts/creative_arts_heads.dart';
import 'package:vnr_connect/screens/clubs/creative_arts/creative_arts_joining_requests.dart';
import 'package:vnr_connect/screens/clubs/creative_arts/creative_arts_members.dart';

class CreativeArtsDesc extends StatefulWidget {
  const CreativeArtsDesc({super.key});

  @override
  CreativeArtsDescState createState() => CreativeArtsDescState();
}

class CreativeArtsDescState extends State<CreativeArtsDesc> {
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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 200, vertical: 75),
        width: 900,
        height: 500,
        padding: EdgeInsets.symmetric(horizontal: 300, vertical: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Description goes here..."),
              SizedBox(
                width: 20,
                height: 20,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                  onPressed: () {},
                  child: Text("Edit")),
            ],
          ),
        ),
      ),
    );
  }
}
