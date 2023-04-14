import 'package:flutter/material.dart';
import 'package:vnr_connect/animation.dart';
import 'package:vnr_connect/screens/animated_login.dart';
import 'package:vnr_connect/screens/email_verification.dart';
import 'package:vnr_connect/services/authenticate.dart';

class AnimatedSignUp extends StatefulWidget {
  const AnimatedSignUp({super.key});

  @override
  State<AnimatedSignUp> createState() => _AnimatedSignUpState();
}

class _AnimatedSignUpState extends State<AnimatedSignUp> {
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  String errstring = "";
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    createDialogBox(BuildContext context) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                  "email is already registered or email is incorrect"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("click to change"))
              ],
            );
          });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 400,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: -40,
                      height: 400,
                      width: width,
                      child: FadeAnimation(
                          1,
                          Container(
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/background.png'),
                                    fit: BoxFit.fill)),
                          )),
                    ),
                    Positioned(
                      height: 400,
                      width: width + 20,
                      child: FadeAnimation(
                          1.3,
                          Container(
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/background-2.png'),
                                    fit: BoxFit.fill)),
                          )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const FadeAnimation(
                        1.5,
                        Text(
                          "Register",
                          style: TextStyle(
                              color: Color.fromRGBO(49, 39, 79, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                        1.7,
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                )
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color.fromARGB(
                                                255, 216, 214, 214)))),
                                child: TextFormField(
                                  controller: name,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Name",
                                      hintStyle: TextStyle(color: Colors.grey)),
                                  onChanged: (value) {
                                    setState(() {
                                      errstring = "";
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "required";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color.fromARGB(
                                                255, 216, 214, 214)))),
                                child: TextFormField(
                                  controller: email,
                                  onChanged: (value) {
                                    setState(() {
                                      errstring = "";
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email Id",
                                      hintStyle: TextStyle(color: Colors.grey)),
                                  validator: (value) {
                                    if (value!.isEmpty) return "Required";
                                    if (!value.endsWith("@gmail.com")) {
                                      return "not a vaild email";
                                    }

                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: password,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey)),
                                  onChanged: (value) {
                                    setState(() {
                                      errstring = "";
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "required";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    
                    FadeAnimation(
                        1.9,
                        Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color.fromRGBO(49, 39, 79, 1),
                          ),
                          child: Center(
                            child: TextButton(
                              onPressed: () async {
                                if (_loginFormKey.currentState!.validate()) {
                                  dynamic result = await AuthService()
                                      .registerWithEmailAndPass(
                                          name.text,email.text, password.text);

                                  if (result) {
                                    if (!mounted) return;
                                    // Navigator.of(context).pop();
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => const EmailVerificationScreen()));

                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                               const EmailVerificationScreen()),
                                        (Route route) => false);
                                  } else {
                                    if (!mounted) return;
                                    createDialogBox(context);
                                  }
                                }
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeAnimation(
                        2,
                        Center(
                            child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const AnimatedLogin())));
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Color.fromRGBO(49, 39, 79, .6)),
                          ),
                        ))),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
