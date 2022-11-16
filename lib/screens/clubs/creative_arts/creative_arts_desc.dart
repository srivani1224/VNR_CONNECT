// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vnr_connect/screens/clubs/creative_arts/creative_arts_options_display.dart';

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
          leading: TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            ),
            icon: Icon(Icons.menu),
            label: Text(""),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreativeArtsOptionsDisplay()),
              );
            },
          ),
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
