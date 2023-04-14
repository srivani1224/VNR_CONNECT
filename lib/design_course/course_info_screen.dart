import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vnr_connect/screens/editevent.dart';
import 'design_course_app_theme.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class CourseInfoScreen extends StatefulWidget {
  final String id;
  const CourseInfoScreen({super.key, required  this.id});

  @override
  State<CourseInfoScreen> createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoScreen> with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  String buttonText="Register";
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
  setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user=FirebaseAuth.instance.currentUser;
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
                .collection("Events")
                .doc(widget.id)
                .snapshots(),
              
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

            if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              Future<dynamic>.delayed(const Duration(milliseconds: 200));
              String eventName=snapshot.data!['eventName'];
               final DateFormat dateFormat = DateFormat("dd-MMM-yy");
               final DateFormat timeFormat = DateFormat("hh:mm a");

               //RegistrationButton
               String link = snapshot.data!['registrationLink'];
              DateTime now = DateTime.now();
              Timestamp ts = snapshot.data!['Datetime'];
              DateTime eventDate = ts.toDate();
              int result = now.compareTo(eventDate);
              if(result>0)
              {
                buttonText="Outdated";
              }
              else if(link.isNotEmpty){
              buttonText="Registration Link";
              }
            return Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.2,
                      child: Image.asset('assets/design_course/webInterFace.png'),
                    ),
                  ],
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: DesignCourseAppTheme.nearlyWhite,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: DesignCourseAppTheme.grey.withOpacity(0.2),
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: SingleChildScrollView(
                        child: Container(
                          constraints: BoxConstraints(
                              minHeight: infoHeight,
                              maxHeight: tempHeight > infoHeight
                                  ? tempHeight
                                  : infoHeight),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                               Padding(
                                padding: const EdgeInsets.only(
                                    top: 32.0, left: 18, right: 16),
                                child: Text(
                                  eventName,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.darkerText,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 8, top: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                     Text(
                                      snapshot.data!['conductedBy'],
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 22,
                                        letterSpacing: 0.27,
                                        color: DesignCourseAppTheme.nearlyBlue,
                                      ),
                                    ),
                                    Row(
                                      children: const <Widget>[
                                        Text(
                                          '4.3',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontSize: 22,
                                            letterSpacing: 0.27,
                                            color: DesignCourseAppTheme.grey,
                                          ),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: DesignCourseAppTheme.nearlyBlue,
                                          size: 24,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: opacity1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      children: <Widget>[
                                        getTimeBoxUI(snapshot.data!['registeredEmails'].length.toString(), 'Registrations'),
                                        getTimeBoxUI('${dateFormat.format(snapshot.data!['Datetime'].toDate())}\n ${timeFormat.format(snapshot.data!['Datetime'].toDate())}', 'Time'),
                                        getTimeBoxUI(snapshot.data!['venue'], 'Venue'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: opacity2,
                                  child:  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                     snapshot.data!['description'] ,
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 14,
                                        letterSpacing: 0.27,
                                        color: DesignCourseAppTheme.grey,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: opacity3,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, bottom: 16, right: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      snapshot.data!['heads'].contains(user!.email)?SizedBox(
                                        width: 48,
                                        height: 48,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: DesignCourseAppTheme.nearlyWhite,
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(16.0),
                                            ),
                                            border: Border.all(
                                                color: DesignCourseAppTheme.grey
                                                    .withOpacity(0.2)),
                                          ),
                                          child: IconButton(icon:  const Icon(
                                            Icons.edit,
                                            color: DesignCourseAppTheme.nearlyBlue,
                                            size: 28,
                                          ), onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: ((context) => EditEvent(doc: snapshot.data!,))));
                                            },),
                                        ),
                                      ):Container(),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: DesignCourseAppTheme.nearlyBlue,
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(16.0),
                                            ),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: DesignCourseAppTheme
                                                      .nearlyBlue
                                                      .withOpacity(0.5),
                                                  offset: const Offset(1.1, 1.1),
                                                  blurRadius: 10.0),
                                            ],
                                          ),
                                          child:  Center(
                                            child: TextButton(
                                              onPressed:() async {
                                               if(buttonText=="Registration Link")
                                               {
                                                dynamic url = snapshot.data!['registrationLink'];
                                                await launchUrl(Uri.parse(url));
                                               }
                                               if(buttonText=="Register")
                                               {
                                                  List<dynamic> registeredEmails=snapshot.data!['registeredEmails'];
                                                  if(registeredEmails.contains(FirebaseAuth.instance.currentUser!.email)){
                                                      showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                            return AlertDialog(
                                                            title: const Text(
                                                            'Already registered'),
                                                            content: const Text(
                                                            'You are already regstered to the event.'),
                                                            actions: [
                                                              TextButton(
                                                                  child: const Text('OK'),
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                                },
                                                              ),
                                                                    ],
                                                                            );
                                                                });
                                               }
                                               else {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection("Events")
                                                          .doc(snapshot.data!.id)
                                                          .update({
                                                        'registeredEmails':
                                                            FieldValue
                                                                .arrayUnion([
                                                          user.email
                                                        ])
                                                      });
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection("Users")
                                                          .doc(user.email)
                                                          .update({
                                                        'registeredEvents':
                                                            FieldValue
                                                                .arrayUnion([
                                                          snapshot.data!.id
                                                        ])
                                                      });
                                                    }
                                              }},
                                              child:  Text(buttonText,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                letterSpacing: 0.0,
                                                color: DesignCourseAppTheme
                                                    .nearlyWhite,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),)
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).padding.bottom,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
                  right: 35,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: CurvedAnimation(
                        parent: animationController!, curve: Curves.fastOutSlowIn),
                    child: Card(
                      color: DesignCourseAppTheme.nearlyBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      elevation: 10.0,
                      child: const SizedBox(
                        width: 60,
                        height: 60,
                        child: Center(
                          child: Icon(
                            Icons.favorite,
                            color: DesignCourseAppTheme.nearlyWhite,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: SizedBox(
                    width: AppBar().preferredSize.height,
                    height: AppBar().preferredSize.height,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(AppBar().preferredSize.height),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: DesignCourseAppTheme.nearlyBlack,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
