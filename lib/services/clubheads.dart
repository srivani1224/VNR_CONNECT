import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ACMPage extends StatelessWidget {
  const ACMPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ACM')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Student Chapters')
            .doc('ACM')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          List<dynamic> heads = snapshot.data?.get('heads');
          return Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Heads', style: TextStyle(fontSize: 20.0)),
                    const SizedBox(height: 16.0),
                    for (var head in heads)
                      Text(head, style: const TextStyle(fontSize: 16.0)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
