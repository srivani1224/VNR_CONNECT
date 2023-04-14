// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:vnr_connect/needed/app_theme.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  List<String> _heads = [];
  String _eventName = '';
  String _conductedBy = '';
  String _description = '';
  String _venue = '';
  String _registrationLink = '';
  String _year = '';
  AnimationController? animationController;
  bool multiple = true;
  final _addEventFormKey = GlobalKey<FormState>();
  Timestamp timestamp = Timestamp.fromDate(DateTime.now());
  List<String> _winners = [], _eventImageUrls = [];
  late DateTime _selectedDateTime = DateTime.now();

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
          timestamp = Timestamp.fromDate(_selectedDateTime);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm a");
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor:
          isLightMode == true ? AppTheme.white : AppTheme.nearlyBlack,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 30, 8, 15),
          child: Form(
            key:_addEventFormKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: <Widget>[
                appBar(),
                _buildComposer("Event Name"),
                _buildComposer("Conducted By"),
                _buildComposer("Venue"),
                _buildComposer("Year"),
                _descriptionBox("Description"),
                // TextField(
                //   style: TextStyle(
                //     color: isLightMode ? Colors.black : Colors.white
                //   ),
                //   onChanged: (value) {
                //     setState(() {
                //       _eventName = value;
                //     });
                //   },
                //   decoration: const InputDecoration(
                //     labelText: 'Event Name',
          
                //   ),
                // ),
                // TextField(
                //   onChanged: (value) {
                //     setState(() {
                //       _conductedBy = value;
                //     });
                //   },
                //   decoration: const InputDecoration(
                //     labelText: 'Conducted by',
                //   ),
                // ),
                // TextField(
                //   onChanged: (value) {
                //     setState(() {
                //       _venue = value;
                //     });
                //   },
                //   decoration: const InputDecoration(
                //     labelText: 'Venue',
                //   ),
                // ),
                // TextField(
                //   onChanged: (value) {
                //     setState(() {
                //       _year = value;
                //     });
                //   },
                //   decoration: const InputDecoration(
                //     labelText: 'year',
                //   ),
                // ),
                // TextField(
                //   maxLines: null,
                //   onChanged: (value) {
                //     setState(() {
                //       _description = value;
                //     });
                //   },
                //   decoration: const InputDecoration(
                //     labelText: 'Description',
                //   ),
                // ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.camera,
                      color: isLightMode ? Colors.black : Colors.white,
                    )),
                ElevatedButton(
                  onPressed: _selectDateTime,
                  child: Text(
                      "Event Date : ${dateFormat.format(_selectedDateTime)}"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Enter Organisers Details",
                  style: TextStyle(
                    color: isLightMode ? Colors.black : Colors.white,
                  ),
                ),
                
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _heads.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == _heads.length) {
                      return IconButton(
                        icon: Icon(
                          Icons.add,
                          color: isLightMode ? Colors.black : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _heads.add('');
                          });
                        },
                      );
                    }
                    return _addOrganiserTextBox(index);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Center(
                    child: Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isLightMode ? Colors.blue : Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              offset: const Offset(4, 4),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if(_addEventFormKey.currentState!.validate()){
                            await FirebaseFirestore.instance
                                .collection("Events")
                                .add({
                              'eventName': _eventName,
                              'description': _description,
                              'Datetime': timestamp,
                              'conductedBy': _conductedBy,
                              'Winners': _winners,
                              'venue': _venue,
                              'heads': _heads,
                              'eventImageUrls': _eventImageUrls,
                              'registrationLink': _registrationLink,
                              'year': _year,
                              'registeredEmails': []
                            });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Successful'),
                                  content: const Text(
                                      'You have successfully added the event'),
                                  actions: [
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            
                            }
          
                          },
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      isLightMode ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComposer(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                offset: const Offset(4, 4),
                blurRadius: 8),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.all(4.0),
            //constraints: const BoxConstraints(minHeight: 20, maxHeight: 160),
            color: AppTheme.white,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: TextFormField(
                // maxLines: null,
                validator: ((value) {
                  if(value!.isEmpty)
                  {
                    return "Required";
                  }
                  return null;
                }),
                onChanged: (String txt) {
                  if (text == "Event Name") {
                    _eventName = txt;
                  } else if (text == "Conducted By") {
                    _conductedBy = txt;
                  } else if (text == "Venue") {
                    _venue = txt;
                  } else if (text == "Year") {
                    _year = txt;
                  }
                },
                style: const TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontSize: 16,
                  color: AppTheme.dark_grey,
                ),
                cursorColor: Colors.blue,
                decoration:
                    InputDecoration(border: InputBorder.none, hintText: text),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _addOrganiserTextBox(int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                offset: const Offset(4, 4),
                blurRadius: 8),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.all(4.0),
            //constraints: const BoxConstraints(minHeight: 20, maxHeight: 160),
            color: AppTheme.white,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: TextField(
                // maxLines: null,

                onChanged: (String txt) {
                  setState(() {
                    _heads[index] = txt;
                  });
                },
                style: const TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontSize: 16,
                  color: AppTheme.dark_grey,
                ),
                cursorColor: Colors.blue,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Organiser Email"),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _descriptionBox(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                offset: const Offset(4, 4),
                blurRadius: 8),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.all(4.0),
            constraints: const BoxConstraints(minHeight: 80, maxHeight: 160),
            color: AppTheme.white,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: TextFormField(
                maxLines: null,
                validator: (txt){
                  if(txt!.isEmpty)
                  {
                    return "required";
                  }
                  return null;
                

                },
                onChanged: (String txt) {
                  _description = txt;

                },
                style: const TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontSize: 16,
                  color: AppTheme.dark_grey,
                ),
                cursorColor: Colors.blue,
                decoration:
                    InputDecoration(border: InputBorder.none, hintText: text),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: SizedBox(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Add Event',
                  style: TextStyle(
                    fontSize: 22,
                    color: isLightMode ? AppTheme.darkText : AppTheme.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
