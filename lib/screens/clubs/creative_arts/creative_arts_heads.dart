// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
//import 'package:vnr_connect/models/heads_model.dart';
import 'package:vnr_connect/screens/clubs/creative_arts/creative_arts_events.dart';
import 'package:vnr_connect/screens/clubs/creative_arts/creative_arts_joining_requests.dart';
import 'package:vnr_connect/screens/clubs/creative_arts/creative_arts_members.dart';
import 'package:vnr_connect/screens/clubs/creative_arts/creative_arts_view_head.dart';
import 'package:vnr_connect/services/database.dart';


class CreativeArtsHeads extends StatefulWidget {
  const CreativeArtsHeads({super.key});

  @override
  CreativeArtsHeadsState createState() => CreativeArtsHeadsState();
}

class CreativeArtsHeadsState extends State<CreativeArtsHeads> {
//       final Stream<List<Head>> _items = DataBase().getHeads("CreativeArts");
//       late List<Head> _y;
//  CreativeArtsHeads(){
// _items.listen((listOfHeads) {
//       for (Head head in listOfHeads) {
//         _y.add(head);
//       }
//     });
//}

      

  final numHeads = DataBase().countHeads("CreativeArts");

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
              onPressed: (){

              },
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
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreativeArtsViewHead()),
                          );
                        },
                        child: Container(
                          color: Colors.lightBlueAccent,
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          height: 100,
                          child: Text("Hi"),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
