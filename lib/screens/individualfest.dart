import "package:flutter/material.dart";
import 'package:vnr_connect/models/fests_model.dart';
import 'package:vnr_connect/screens/events.dart';

class IndividualFest extends StatelessWidget {
  final Fest fest;
  const IndividualFest({super.key, required this.fest});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${fest.festName}  ${fest.festYear}"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Center(
            child: Column(
              children: [
                const Text("Descrption goes here"),
                const SizedBox(
                  height: 10,
                ),
                Events()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
