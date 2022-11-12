import 'package:flutter/material.dart';
//import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: const Text('VNR CONNECT'),
          centerTitle: true,
          actions: const [
            TextButton(
                onPressed: null,
                child: Text("Register",
                    style: TextStyle(
                      color: Colors.white,
                    ))),
            TextButton(
                onPressed: null,
                child: Text("Login",
                    style: TextStyle(
                      color: Colors.white,
                    ))),
          ]),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: const <Widget>[
              //Carousel(),
              SizedBox(
                width: 300,
                height: 200,
              ),
              Card(
                  color: Colors.lightBlueAccent,
                  margin: EdgeInsets.all(20),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 40),
                    child: Text("Clutural clubs"),
                  )),
              Card(
                color: Colors.lightBlueAccent,
                margin: EdgeInsets.all(20),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 40),
                  child: Text("Clutural clubs"),
                ),
              ),
              Card(
                color: Colors.lightBlueAccent,
                margin: EdgeInsets.all(20),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 40),
                  child: Text("Clutural clubs"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
