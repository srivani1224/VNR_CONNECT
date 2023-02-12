// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vnr_connect/models/clubs_model.dart';
import 'package:vnr_connect/providers/provider_club.dart';
import 'package:vnr_connect/screens/login_form.dart';
import 'package:vnr_connect/services/authenticate.dart';

class HomeClubs extends StatefulWidget {
  const HomeClubs({super.key});

  @override
  HomeClubState createState() => HomeClubState();
}

class HomeClubState extends State<HomeClubs> {
  final List<ClubsModel> _items = [
    ClubsModel("Live Wire", "LiveWireDesc"),
    ClubsModel("Crescendo", "CrescendoDesc"),
    ClubsModel("Creative Arts", "CreativeArtsDesc"),
    ClubsModel("VJ Teatro", "VJTeatroDesc"),
    ClubsModel("Scintillate", "ScintillateDesc"),
    ClubsModel("Stentorian", "StentorianDesc"),
    ClubsModel("Vignana Jyothi Sahiti Vanam", "SahitiVanamDesc"),
    ClubsModel("Dramatrix", "DramatrixDesc"),
    ClubsModel("N Army", "NArmyDesc"),
  ];

  final ProviderClub _providerClub = ProviderClub();

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
              onPressed: () async {
                await AuthService().signOut();
                if (!mounted) return;
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginForm()),
                    (Route route) => false);
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
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => _providerClub
                                    .mapFunction(_items[index].clubOnPressed)),
                          );
                        },
                        child: Container(
                          color: Colors.lightBlueAccent,
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          height: 100,
                          child: Center(child: Text(_items[index].clubName)),
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
