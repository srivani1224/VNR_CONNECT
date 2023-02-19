// ignore_for_file: prefer_const_constructors, avoid_print, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/events.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/heads.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/joining_requests.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/members.dart';

class ViewHead extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> s;
  final String path;
  const ViewHead(this.path, this.s, {super.key});

  @override
  ViewHeadState createState() => ViewHeadState();
}

class ViewHeadState extends State<ViewHead> {
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
          child: ListView(
            padding: const EdgeInsets.fromLTRB(50, 60, 50, 80),
            children: <Widget>[
              Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTId_fAVBdS536njw7MXHbKcJYi5Uh0ZhV6Kg&usqp=CAU'),
              SizedBox(
                height: 30,
                child: Text(
                  "Name : " + widget.s.get('Name'),
                  style: TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                child: Text(
                  "Email_Id : " + widget.s.get('Email_Id'),
                  style: TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                child: Text(
                  "Department : " + widget.s.get('Department'),
                  style: TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                child: Text(
                  "Contact_Number : " + widget.s.get('Contact_Number'),
                  style: TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                child: Text(
                  "Student/Faculty : " + widget.s.get('Student_Faculty'),
                  style: TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
