import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:vnr_connect/models/fests_model.dart';
import 'package:vnr_connect/needed/app_theme.dart';
import 'package:vnr_connect/screens/add_event.dart';
import 'package:vnr_connect/screens/events_in_a_year.dart';

class IndividualFest extends StatefulWidget {
  final Fest fest;

  const IndividualFest({super.key, required this.fest});

  @override
  State<IndividualFest> createState() => _IndividualFestState();
}

class _IndividualFestState extends State<IndividualFest> {
  bool canPerformAction = false;
  @override
  void initState() {
    super.initState();
    checkUserPermission();
  }

  void checkUserPermission() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    DocumentSnapshot<Map<String, dynamic>> organisers = await FirebaseFirestore
        .instance
        .collection("MetaData")
        .doc("Organisers")
        .get();

    if (user != null) {
      setState(() {
        canPerformAction =
            organisers[widget.fest.festYear].contains(user.email);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String collectionName = widget.fest.festName + widget.fest.festYear;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor:
          isLightMode == true ? AppTheme.white : AppTheme.nearlyBlack,
      // appBar: AppBar(
      //   title: Text("${widget.fest.festName}  ${widget.fest.festYear}"),
      //   actions: [
      //     canPerformAction
      //         ? TextButton.icon(
      //             style: TextButton.styleFrom(
      //               foregroundColor: Colors.white,
      //             ),
      //             onPressed: () {
      //               Navigator.of(context).push(MaterialPageRoute(
      //                   builder: ((context) => const AddEvent())));
      //             },
      //             icon: const Icon(Icons.add),
      //             label: const Text("Add"),
      //           )
      //         : Container(),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 20),
        child: Center(
          child: Column(
            children: [
               appBar(),
              Flexible(
                  child: NewEvents(
                collection: collectionName,
                selectedYear: widget.fest.festYear,
              ))
            ],
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
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              color: isLightMode ? Colors.white : AppTheme.nearlyBlack,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                   // multiple ? Icons.dashboard : Icons.view_agenda,
                   Icons.keyboard_arrow_left,
                    color: isLightMode ? AppTheme.dark_grey : AppTheme.white,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                 widget.fest.festYear,
                  style: TextStyle(
                    fontSize: 22,
                    color: isLightMode ? AppTheme.darkText : AppTheme.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          canPerformAction?Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              color: isLightMode ? Colors.white : AppTheme.nearlyBlack,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                   // multiple ? Icons.dashboard : Icons.view_agenda,
                   Icons.add,
                    color: isLightMode ? AppTheme.dark_grey : AppTheme.white,
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) =>const AddEvent())));
                  },
                ),
              ),
            ),
          ):Container(),
        ],
      ),
    );
  }
}
