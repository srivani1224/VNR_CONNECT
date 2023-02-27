import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:vnr_connect/models/fests_model.dart';
import 'package:vnr_connect/screens/Individualevent.dart';

class Events extends StatefulWidget {
  final String collection;
  const Events({super.key,required this.collection});
  

  @override
  // ignore: library_private_types_in_public_api
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection(widget.collection).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.data?.size==0)
          {
            return const Center(child: Text("No data found"));
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: <Widget>[
                      Image(
                          image: NetworkImage((document.data()
                              as Map<String, dynamic>)['eventImageUrls'][0])),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        (document.data() as Map<String, dynamic>)['eventName'],
                        style: const TextStyle(fontSize: 40, color: Colors.red),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        (document.data() as Map<String, dynamic>)['venue'],
                        style: const TextStyle(
                            fontSize: 30, color: Colors.redAccent),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                         List<dynamic> details = (document.data()
                                  as Map<String, dynamic>)['heads'] ?? [];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                            
                                builder: (context) =>  EventDetails(alldocs: details,doc: document,)),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.deepOrange[400],
                        ),
                        child: const Text("View"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
