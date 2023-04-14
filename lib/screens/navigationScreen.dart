
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vnr_connect/screens/home.dart';
import 'package:vnr_connect/screens/instaprofile.dart';
import 'package:vnr_connect/screens/registered_Events.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  Widget divider() {
    return const Divider(
      color: Colors.black,
      height: 2.0,
    );
  }
User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text("UserName"),
              accountEmail:  Text(user!.email.toString()),
              currentAccountPicture: CircleAvatar(
                backgroundImage: const NetworkImage(
                    'https://i.pinimg.com/474x/5b/ba/76/5bba763062eedbb628779215a24848b1.jpg'),
                backgroundColor: Colors.redAccent[200],
                
              ),
              onDetailsPressed: (() {
                Navigator.push(context, MaterialPageRoute(builder: ((context) =>
                 //ProfilePage()
                 MyProfile(email: user!.email.toString(),)
                )));
              }),
            ),
          ],
        ),
        ListTile(
          title: const Text("About"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const Home();
            }));
          },
        ),
        const Divider(
          color: Colors.black,
          height: 2.0,
        ),
        ListTile(
          title: const Text("My Registered Events"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const MyRegistrations();
            }));
          },
        ),
        
             const Divider(
              color: Colors.black,
              height: 2.0,
            ),
            ListTile(
              title: const Text("Request"),
              onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) {
                 return const Home();
               },));
              },
            ),
      ],
    );
  }
}
