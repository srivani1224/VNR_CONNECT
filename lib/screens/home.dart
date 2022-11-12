// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
];

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
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                CarouselSlider(
                  items: imgList
                      .map((item) => Container(
                            child: Center(
                              child: Image.network(
                                item,
                                fit: BoxFit.cover,
                                width: 1000,
                              ),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Card(
                      color: Colors.lightBlueAccent,
                      margin: EdgeInsets.all(20),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 40),
                        child: Text("Clutural clubs"),
                      )),
                ),
                InkWell(
                  onTap: () {},
                  child: Card(
                      color: Colors.lightBlueAccent,
                      margin: EdgeInsets.all(20),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 90, vertical: 40),
                        child: Text("Student Chapters"),
                      )),
                ),
                InkWell(
                  onTap: () {},
                  child: Card(
                      color: Colors.lightBlueAccent,
                      margin: EdgeInsets.all(20),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 127, vertical: 40),
                        child: Text("Fests"),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
