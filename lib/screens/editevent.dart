// ignore_for_file: use_build_context_synchronously, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class EditEvent extends StatefulWidget {
  DocumentSnapshot doc;
  EditEvent({super.key, required this.doc});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController conductedByController = TextEditingController();

  bool canPerformAction = false;
  late DateTime _selectedDateTime = widget.doc['Datetime'].toDate();
  String description = "";
  late Timestamp timestamp;
  List<String> _items = [];

  @override
  void initState() {
    super.initState();

  }



  Future<void> _selectDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: _selectedDateTime.hour, minute: _selectedDateTime.minute),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm a");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Event"),
        actions: [
          TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              onPressed: () {},
              icon: const Icon(Icons.logout),
              label: const Text("Logout"))
        ],
      ),
      body: StatefulBuilder(
        builder: ((BuildContext context, StateSetter setState) =>
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Events')
                  .doc(widget.doc.id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                var userDocument = snapshot.data;
                _eventNameController.text = userDocument!['eventName'];
                _descriptionController.text = userDocument['description'];
                conductedByController.text = userDocument['conductedBy'];
                description = userDocument['description'];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _eventNameController,
                          decoration:
                              const InputDecoration(labelText: 'Profile Name'),
                        ),
                        TextFormField(
                          maxLines: null,
                          controller: _descriptionController,
                          decoration:
                              const InputDecoration(labelText: 'Description'),
                        ),
                        TextFormField(
                          controller: conductedByController,
                          decoration:
                              const InputDecoration(labelText: "Conducted by"),
                        ),
                        ElevatedButton(
                          onPressed: _selectDateTime,
                          child: Text(
                              "Event Date : ${dateFormat.format(_selectedDateTime)}"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Enter Winners Emails"),
                        const SizedBox(height: 10,),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
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
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter an item',
                              ),
                            );
                          },
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            timestamp = Timestamp.fromDate(_selectedDateTime);
                            await FirebaseFirestore.instance
                                .collection('Events')
                                .doc(widget.doc.id)
                                .update({
                              'eventName': _eventNameController.text,
                              'description': _descriptionController.text,
                              'Datetime': timestamp,
                              'conductedBy': conductedByController.text,
                              'Winners': _items
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Event Details updated')),
                            );

                            Navigator.of(context).pop();
                          },
                          child: const Text('Save'),
                        ),
                         ElevatedButton(
                          onPressed: () async {
                            timestamp = Timestamp.fromDate(_selectedDateTime);
                            await FirebaseFirestore.instance
                                .collection('Events')
                                .doc(widget.doc.id)
                                .delete();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Event Deleted')),
                            );

                            Navigator.of(context).pop();
                          },
                          child: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
