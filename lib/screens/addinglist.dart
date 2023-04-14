// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   List<String> _items = [];
   TextEditingController inputText=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Inputs'),
      ),
      body: ListView.builder(
        itemCount: _items.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == _items.length) {
            // Add a button to add more items to the list
            return IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  _items.add('');
                });
              },
            );
          }
          return TextField(
            onChanged: (value) {
              // Update the value in the list
              setState(() {
                _items[index] = value;
                inputText.text=_items[index];
              });
            },
            decoration: const InputDecoration(
              hintText: 'Enter an item',
            ),
            
          );
        },
      ),
    );
  }
}
