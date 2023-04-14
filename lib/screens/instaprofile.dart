import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vnr_connect/screens/pages/profile_page.dart';

class MyProfile extends StatefulWidget {
  final String email;
  const MyProfile({super.key, required this.email});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  @override
  void initState() {
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black87),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
          ), onPressed: () {
            Navigator.of(context).pop();
            },
        ),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(widget.email)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          //Map<String, dynamic> userDetails =
          //snapshot.data! as Map<String, dynamic>;
          User? user = FirebaseAuth.instance.currentUser;
          bool showFollowButton=true,showFollowing=false;
          if(user!.email==widget.email)
          {
            showFollowButton=false;
          }
          if(showFollowButton)
          {
            if(snapshot.data!['followers'].contains(user.email))
            {
              showFollowing=true;
            }
          }
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            snapshot.data!['profileImage']),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            snapshot.data!['Name'],
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            snapshot.data!['EmailAddress'],
                            style: TextStyle(
                                color: Colors.blueGrey[400],
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: width / 3,
                              height: 40,
                              padding: const EdgeInsets.only(left: 20),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color.fromARGB(
                                                255, 158, 202, 238)),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color.fromARGB(
                                                255, 157, 204, 227))),
                                onPressed: () async {

                                  if(showFollowing)
                                  {
                                    return;
                                  }
                                  if(showFollowButton)
                                  {
                                    FirebaseFirestore.instance.collection("Users").doc(user.email).update({'following':FieldValue.arrayUnion([widget.email])});
                                  }
                                  Navigator.of(context).pop();
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return  ProfilePage(email:user.email.toString());
                                  },));
                                  
                                },
                                child: Text(
                                  showFollowButton?showFollowing?"Following":'Follow':"Edit",
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width / 5,
                            ),
                            Container(
                              height: 40,
                              width: width / 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border:
                                    Border.all(width: 1, color: Colors.black87),
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.message,
                                color: Colors.blueGrey[400],
                              )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Divider(
                      thickness: 1,
                      color: Colors.blueGrey[200],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data!['followers'].length.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 20),
                            ),
                            const Text(
                              'Followers',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.blueGrey),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data!['following'].length.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 20),
                            ),
                            const Text(
                              'Following',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.blueGrey),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data!['registeredEvents'].length
                                  .toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 20),
                            ),
                            const Text(
                              'Registered Events',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.blueGrey),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(0),
                            //   child: TextButton(
                            //       onPressed: (() {}),
                            //       child: const Text("Registered Events",
                            //       style: TextStyle(
                            //         fontSize: 15, color: Colors.blueGrey),)),
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Divider(
                      thickness: 1,
                      color: Colors.blueGrey[200],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 30),
                        child: const Text(
                          'Top Skills',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.grey[300],
                              ),
                              child: const Center(
                                  child: Text(
                                'Flutter',
                                style: TextStyle(color: Colors.blueGrey),
                              )),
                            ),
                            Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.grey[300],
                              ),
                              child: const Center(
                                  child: Text(
                                'React JS',
                                style: TextStyle(color: Colors.blueGrey),
                              )),
                            ),
                            Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.grey[300],
                              ),
                              child: const Center(
                                  child: Text(
                                'Node js',
                                style: TextStyle(color: Colors.blueGrey),
                              )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.grey[300],
                              ),
                              child: const Center(
                                  child: Text(
                                'Django',
                                style: TextStyle(color: Colors.blueGrey),
                              )),
                            ),
                            Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.grey[300],
                              ),
                              child: const Center(
                                  child: Text(
                                'Laravel',
                                style: TextStyle(color: Colors.blueGrey),
                              )),
                            ),
                            Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.grey[300],
                              ),
                              child: const Center(
                                  child: Text(
                                'Express JS',
                                style: TextStyle(color: Colors.blueGrey),
                              )),
                            ),
                            // Container(
                            //   width: 100,
                            //   height: 40,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(30),
                            //     color: Colors.grey[300],
                            //   ),
                            //   child: const Center(child: Text('Tensorflow', style: TextStyle(color: Colors.blueGrey),)),
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Projects',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w900),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.network(
                                    'https://www.techuz.com/blog/wp-content/uploads/2019/06/Technology-Stack_Banner-1280x720.jpg',
                                  )),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  child: const Text(
                                    'MERN Stack Project',
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              ],
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 250,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.network(
                                      'https://appsmaventech.com/images/blog/React-Native-Vs-Flutter-What-Is-Better-For-Your-Business.jpg',
                                    )),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10),
                                    child: const Text(
                                      'Flutter vs React',
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
