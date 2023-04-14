
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vnr_connect/design_course/course_info_screen.dart';

class NewEvents extends StatefulWidget {
  final String collection;
  final String selectedYear;
  const NewEvents({super.key, required this.collection,required this.selectedYear});

  @override
  // ignore: library_private_types_in_public_api
  _NewEventsState createState() => _NewEventsState();
}

class _NewEventsState extends State<NewEvents> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
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

          // Filter events that match the selected year
          List<QueryDocumentSnapshot> eventsInSelectedYear = allEvents
              .where((event) => event['year'] == widget.selectedYear)
              .toList();

              if (eventsInSelectedYear.isEmpty) {
            return const Center(child: Text("No data found"));
          }
            return ListView.builder(
              itemCount: eventsInSelectedYear.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot document =eventsInSelectedYear[index];
                    Timestamp ts = (document.data() as Map<String, dynamic>)['Datetime'];
                    List<dynamic> registeredEmails=document['registeredEmails'];
                    List<dynamic> imageUrls = document['eventImageUrls'];
                    DateTime date =ts.toDate();
                    String year =date.year.toString();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    tileColor: const Color.fromARGB(255, 211, 213, 213),
                    title: Text((document.data() as Map<String, dynamic>)['eventName'],
                    style: const TextStyle(fontWeight: FontWeight.bold),),
                    leading: imageUrls.isNotEmpty?Image(image: NetworkImage((document.data()
                                as Map<String, dynamic>)['eventImageUrls'][0])):Image.asset("assets/design_course/webInterFace.png"),
                    subtitle: Text(year),
                    trailing: Text(registeredEmails.length.toString()),
              onTap: () {
  
                            String id =document.id.toString();
                            Navigator.of(context).push(MaterialPageRoute(builder:((context) => CourseInfoScreen(id:id) ) ));
                 // Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventDetails(alldocs: details, doc: document,collection: widget.collection,)));
              },
                  ),
                );
              },
            );
          },
        ),
      
    );
  }
  
}
