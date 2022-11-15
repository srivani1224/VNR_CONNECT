import "package:flutter/material.dart";
import 'package:vnr_connect/models/eventsmodel.dart';
import 'package:vnr_connect/screens/fests.dart';

class Events extends StatelessWidget {
final List<Event> events = [Event(imageUrl:"https://wallpapercave.com/wp/wp2349410.jpg",name: "Event 1"),
Event(imageUrl:"https://wallpapercave.com/wp/wp2349410.jpg",name: "Event 1"),
Event(imageUrl:"https://wallpapercave.com/wp/wp2349410.jpg",name: "Event 1"),
Event(imageUrl:"https://wallpapercave.com/wp/wp2349410.jpg",name: "Event 1"),
Event(imageUrl:"https://wallpapercave.com/wp/wp2349410.jpg",name: "Event 1")];

 Events({super.key});
 
  @override
  Widget build(BuildContext context) {
    
Widget eventTemplate(event) {
      return Card(
        margin: const EdgeInsets.fromLTRB(25.0, 15.5, 25.0, 15.5),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Image(image: NetworkImage(event.imageUrl)),
              const SizedBox(
                height: 20,
              ),
              Text(
                event.name,
                style: const TextStyle(fontSize: 40, color: Colors.red),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                event.date.toString(),
                style: const TextStyle(fontSize: 30, color: Colors.redAccent),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Fests()),
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
    }
 
    return  Center(
      child: Column(children:events.map((event) => eventTemplate(event)).toList()),
    );
  }
}