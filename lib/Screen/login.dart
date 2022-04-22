// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
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
                height: MediaQuery.of(context).size.height * 0.5,
                child: Transform.scale(
                    scale: 0.6, child: Image.asset(UI.app_logo)),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Text(
                          //   "LOG IN",
                          //   style: TextStyle(
                          //       fontSize: 30, fontWeight: FontWeight.bold),
                          // ),
                          Input(
                              validation: "Email required !!",
                              title: "Email",
                              border: Colors.black,
                              fill: Colors.white,
                              text: Colors.black),
                          Password(),
                          Button(
                              title: 'Log In',
                              buttonColor: UI.appColor,
                              textColor: Colors.white,
                              destination: '/root',
                              icon: Icon(Icons.login_rounded))
                        ]),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: Text(
                              'Register',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/forgot');
                            },
                            child: Text(
                              'Forgot password?',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
        )
      ],
    ));
  }
}
