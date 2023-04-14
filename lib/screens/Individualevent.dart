// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: prefer_const_constructors, file_names, use_build_context_synchronously, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vnr_connect/screens/editevent.dart';
import 'package:vnr_connect/screens/login_form.dart';
import 'package:vnr_connect/services/authenticate.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class EventDetails extends StatefulWidget {
  final List<dynamic> alldocs;
  DocumentSnapshot doc;
  String collection;
  EventDetails({super.key, required this.alldocs, required this.doc,required this.collection});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  bool canPerformAction = false;

  @override
  void initState() {
    super.initState();

    checkUserPermission();
  }

  void checkUserPermission() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      setState(() {
        canPerformAction = widget.alldocs.contains(user.email);
      });
    }
  }

  bool showRegistrationbutton() {
    String link = widget.doc['registrationLink'];
    DateTime now = DateTime.now();
    Timestamp ts = widget.doc['Datetime'];
    DateTime eventDate = ts.toDate();
    int result = now.compareTo(eventDate);

    if (link.isEmpty || result > 0) {
      return false;
    }

    return true;
  }

  bool isPresentEvent() {
    DateTime now = DateTime.now();
    Timestamp ts = widget.doc['Datetime'];
    DateTime eventDate = ts.toDate();
    int result = now.compareTo(eventDate);
    if (result <= 0) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> imageUrls = widget.doc['eventImageUrls'];
    List<dynamic> winners = widget.doc['Winners'];
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm a");
    DateTime eventDate = widget.doc['Datetime'].toDate();
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 38, 34, 34),
        appBar: AppBar(
          title: const Text("Event 1"),
          actions: [
            canPerformAction
                ? TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => EditEvent(
                                doc: widget.doc,
                              ))));
                      //builder: ((context) =>DateTimeScreen())));
                    },
                    icon: Icon(Icons.edit),
                    label: Text("Edit"),
                  )
                : Container(),
                TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              onPressed: () async {
                await AuthService().signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginForm()),
                    (Route route) => false);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  GradientText(widget.doc['eventName'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                      colors: const [
                        Color.fromARGB(157, 0, 227, 253),
                        Colors.amber,
                        Color.fromARGB(255, 251, 0, 0),
                      ]),

                  //conducted by text
                  Text(
                    "conducted by ${widget.doc['conductedBy']}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decorationColor: Color.fromARGB(255, 1, 254, 254),
                      color: Color.fromARGB(255, 19, 160, 160),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  //images
                  imageUrls.isNotEmpty
                      ? Image(
                          image: NetworkImage(widget.doc['eventImageUrls'][0]))
                      : Container(),

                  SizedBox(
                    height: 20,
                  ),

                  //Registration button
                  showRegistrationbutton()
                      ? ElevatedButton(
                          child: Text('Go to registration form'),
                          onPressed: () async {
                            dynamic url = widget.doc['registrationLink'];

                            await launchUrl(Uri.parse(url));
                          },
                        )
                      :isPresentEvent()?ElevatedButton(onPressed: (() async{
                        User? user =FirebaseAuth.instance.currentUser;

                        DocumentSnapshot ds= await FirebaseFirestore.instance.collection("Events").doc(widget.doc.id).get();
                        Map<String,dynamic>? thisDocument = ds.data() as Map<String,dynamic>;
                        
                      
                          List<dynamic> registeredEmails=thisDocument['registeredEmails'];
                        if(registeredEmails.contains(user!.email)){
                          showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                            'Already registered'),
                                        content: const Text(
                                            'You are already regstered to the event.'),
                                        actions: [
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                        }
                        else {
                          
                          await FirebaseFirestore.instance.collection("Events").doc(widget.doc.id).update({'registeredEmails':FieldValue.arrayUnion([user.email])});
                          await FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc(user.email)
                                      .update({
                                    'registeredEvents':
                                        FieldValue.arrayUnion([widget.doc.id])
                                  });
                        }
                      }), child: Text("Register")) :Container(),
                  //Image.asset("assets/icons8-trophy-48.png"),
                  Row(
                    children: [
                      winners.isNotEmpty
                          ? SvgPicture.asset(
                              "assets/winner.svg",
                              height: 100,
                              width: 100,
                            )
                          : Container(),
                      Column(
                        children: [
                          winners.isNotEmpty
                              ? Text(
                                  "Winners",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )
                              : Container(),
                          winners.isNotEmpty
                              ? Column(
                                  children: winners
                                      .map((winner) => Text(
                                            winner,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                      .toList(),
                                )
                              : Container(),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            'assets/calendar.svg',
                            width: screenWidth / 6,
                            height: 80,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Event Date",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                dateFormat.format(eventDate).split(" ")[0],
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "${dateFormat.format(eventDate).split(" ")[1]} ${dateFormat.format(eventDate).split(" ")[2]} ",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
