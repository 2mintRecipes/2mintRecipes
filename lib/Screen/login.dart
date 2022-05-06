// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_first/Screen/homepage.dart';
import 'package:flutter_first/Screen/root.dart';
import 'package:flutter_first/components/button.dart';
import '../app_ui.dart';
import '../components/password.dart';
import '../components/input.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const routeName = '/login';
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        SafeArea(
            child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  filterQuality: FilterQuality.low,
                  fit: BoxFit.fitHeight,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.darken),
                  image: AssetImage("images/welcome_bg.jpg"))),
        )),
        SingleChildScrollView(
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Transform.scale(
                    scale: 0.6, child: Image.asset(UI.app_logo)),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Text(
                                  //   "LOG IN",
                                  //   style: TextStyle(
                                  //       fontSize: 30, fontWeight: FontWeight.bold),
                                  // ),
                                  Input(
                                      icon: Icons.alternate_email_outlined,
                                      hintText: 'Email',
                                      isPassword: false,
                                      isEmail: true,
                                      textController: emailController),
                                  Password(
                                    hintText: "Password",
                                  ),
                                  Button(
                                    title: 'Log In',
                                    buttonColor: UI.appColor,
                                    textColor: Colors.white,
                                    destination: '/root',
                                    icon: Icon(Icons.login_rounded),
                                    onTap: () {
                                      //FirebaseAuth.instance
                                      //     .signInWithEmailAndPassword(
                                      //         email: emailController.text,
                                      //         password: passwordController.text)
                                      //     .then((value) {
                                      //   Navigator.push(context,
                                      //       MaterialPageRoute(builder: (context) => Homepage()));
                                      // }).onError((error, stackTrace) {
                                      //   print("Error ${error.toString()}");
                                      // });
                                    },
                                  )
                                ]),
                            Container(
                              padding: EdgeInsets.only(top: 30),
                              width: 300,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/signup');
                                    },
                                    child: Text(
                                      'Register',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/forgot');
                                    },
                                    child: Text(
                                      'Forgot password?',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
            ],
          )),
        )
      ],
    ));
  }
}
