import "package:flutter/material.dart";
import 'package:vnr_connect/models/festmodel.dart';
import 'package:vnr_connect/screens/individualfest.dart';
 class Fests extends StatefulWidget {
  const Fests({super.key});

  @override
  State<Fests> createState() => _FestsState();
}

class _FestsState extends State<Fests> {

 List<Fest> festsData=[
  Fest(festName: "Sinti", festYear: "2k22",festImage:"https://thumbs.dreamstime.com/b/audience-hands-air-music-festival-59879684.jpg"),
  Fest(festName: "Sinti", festYear: "2k21",festImage:"https://thumbs.dreamstime.com/b/audience-hands-air-music-festival-59879684.jpg"),
  Fest(festName: "Sinti", festYear: "2k20",festImage:"https://thumbs.dreamstime.com/b/audience-hands-air-music-festival-59879684.jpg"),
  Fest(festName: "Sinti", festYear: "2k19",festImage:"https://thumbs.dreamstime.com/b/audience-hands-air-music-festival-59879684.jpg"),
  Fest(festName: "Sinti", festYear: "2k18",festImage:"https://thumbs.dreamstime.com/b/audience-hands-air-music-festival-59879684.jpg")
];

//card template

// ignore: avoid_types_as_parameter_names
Widget festTemplate(fest){
  return  Card(
    margin: const EdgeInsets.fromLTRB(25.0, 15.5, 25.0, 15.5),
    elevation: 5.0,
    child: Padding(padding: const EdgeInsets.all(5.0),
    child: Column(
        children:  <Widget> [
          Image(image: NetworkImage(fest.festImage)),
          const SizedBox(height: 20,),
          Text(
            fest.festName,
            style: const TextStyle(
              fontSize: 40,
              color: Colors.red
            ),
          ),
          const SizedBox(height: 6,),
          Text(fest.festYear,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.redAccent
          ),),
          const SizedBox(height: 20,),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>   IndividualFest(fest: fest,)),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepOrange[400],
              ),
              child: const Text("View"),
            ),
            const SizedBox(height: 20,),
        ],
    ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:const Text("Sinti"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: festsData.map((fest)=>festTemplate(fest)).toList(),
          ),
        ),
      )
    );
  }
}