import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vnr_connect/design_course/course_info_screen.dart';
import 'package:vnr_connect/needed/app_theme.dart';

class MyRegistrations extends StatefulWidget {
  const MyRegistrations({super.key});

  @override
  State<MyRegistrations> createState() => _MyRegistrationsState();
}

class _MyRegistrationsState extends State<MyRegistrations> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   AnimationController? animationController;
  bool multiple = true;
   @override
  void initState() {
    super.initState();
  }
Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }
  @override
  Widget build(BuildContext context) {
     var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor:
          isLightMode == true ? AppTheme.white : AppTheme.nearlyBlack,
      
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            appBar(),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection("Events").snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data?.size == 0) {
                    return const Center(child: Text("No data found"));
                  }
                  List<QueryDocumentSnapshot> allEvents = snapshot.data!.docs;
                  User? user = FirebaseAuth.instance.currentUser;
                // Filter events that match the selected year
                List<QueryDocumentSnapshot> eventsInSelectedYear = allEvents
                    .where((event) => event['registeredEmails'].contains(user!.email))
                    .toList();
            
                    if (eventsInSelectedYear.isEmpty) {
                  return const Center(child: Text("No data found"));
                }
                  return ListView.builder(
                    itemCount: eventsInSelectedYear.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot document =eventsInSelectedYear[index];
                          Timestamp ts = (document.data() as Map<String, dynamic>)['Datetime'];
                          List<dynamic> imageUrls = document['eventImageUrls'];
                          DateTime date =ts.toDate();
                          String year =date.year.toString();
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(8.0),
                          tileColor: const Color.fromARGB(255, 211, 213, 213),
                          title: Text((document.data() as Map<String, dynamic>)['eventName'],
                          style: const TextStyle(fontWeight: FontWeight.bold),),
                          leading: imageUrls.isNotEmpty?Image(image: NetworkImage((document.data()
                                      as Map<String, dynamic>)['eventImageUrls'][0])): Image.asset(
                                    "assets/design_course/webInterFace.png"),
                          subtitle: Text(year),
                          trailing: Text(document['registeredEmails'].length.toString()),
                    onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>CourseInfoScreen(id: document.id)));
                    },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      )
      //),
    );
  }
  
  Widget appBar() {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: SizedBox(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Registered Events',
                  style: TextStyle(
                    fontSize: 22,
                    color: isLightMode ? AppTheme.darkText : AppTheme.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}


