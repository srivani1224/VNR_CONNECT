import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vnr_connect/needed/navigation_home_screen.dart';
import 'package:vnr_connect/services/authenticate.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  bool emailverificationStatus = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();
     _checkEmailVerificationStatus();
  }

  Future<void> _checkEmailVerificationStatus() async {
    User? user = _auth.currentUser;
    await user!.reload();
    if (user.emailVerified) {
      emailverificationStatus = true;
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (emailverificationStatus) {
      return const NavigationHomeScreen();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Please verify your email address'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _auth.currentUser!.sendEmailVerification();
                timer = Timer.periodic(const Duration(seconds: 5), ((timer) {
                  checkEmailVerified();
                }));
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Email verification sent'),
                      content: const Text(
                          'A verification email has been sent to your email address. Please follow the instructions in the email to verify your account.'),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Send verification email'),
            ),
            // const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () async {
            //     User? user = _auth.currentUser;
            //     await user!.reload();
            //     await user.reload();
            //     if (user.emailVerified) {
            //       showDialog(
            //         context: context,
            //         builder: (BuildContext context) {
            //           return AlertDialog(
            //             title: const Text('Email verified'),
            //             content: const Text(
            //                 'Your email address has been successfully verified. You can now use your account.'),
            //             actions: [
            //               TextButton(
            //                 child: const Text('OK'),
            //                 onPressed: () {
            //                   Navigator.pop(context);
            //                 },
            //               ),
            //             ],
            //           );
            //         },
            //       );
            //     } else {
            //       showDialog(
            //         context: context,
            //         builder: (BuildContext context) {
            //           return AlertDialog(
            //             title: const Text('Email not verified'),
            //             content: const Text(
            //                 'Your email address has not been verified yet. Please check your email and follow the instructions to verify your account.'),
            //             actions: [
            //               TextButton(
            //                 child: const Text('OK'),
            //                 onPressed: () {
            //                   Navigator.pop(context);
            //                 },
            //               ),
            //             ],
            //           );
            //         },
            //       );
            //     }
            //   },
            //   child: const Text('Check verification status'),
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = _auth.currentUser!;
    await user.reload();
    if(user.emailVerified)
    {
      timer.cancel();
      AuthService().addUser();
      if(!mounted) {
        return ;
      }
      Navigator.of(context).pop();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const NavigationHomeScreen()),
          (Route route) => false);
      //Navigator.push(context, MaterialPageRoute(builder: ((context) => const Home())) );
    }
  }
}
