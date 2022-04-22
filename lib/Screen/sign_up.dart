// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_first/components/button.dart';
import '../app_ui.dart';
import '../components/input.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static const routeName = '/signup';

  @override
  State<SignUp> createState() => _SignUpState();
}

Widget signInWith(String icon) {
  return Container(
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.withOpacity(0), width: 0),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageIcon(
          AssetImage(icon),
          size: 24,
          color: Colors.white,
        ),
        TextButton(
            onPressed: () {},
            child: Text('Sign In', style: TextStyle(color: Colors.white))),
      ],
    ),
  );
}

class _SignUpState extends State<SignUp> {
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                child: Transform.scale(
                    scale: 0.6, child: Image.asset(UI.app_logo)),
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Input(
                        validation: "Fullname",
                        title: "Fullname required",
                        border: Colors.black,
                        fill: Colors.white,
                        text: Colors.black),
                    Input(
                        validation: "Username",
                        title: "Username required",
                        border: Colors.black,
                        fill: Colors.white,
                        text: Colors.black),
                    Input(
                        validation: "Email required !!",
                        title: "Email",
                        border: Colors.black,
                        fill: Colors.white,
                        text: Colors.black),
                    Input(
                        validation: "Password required !!",
                        title: "Password",
                        border: Colors.black,
                        fill: Colors.white,
                        text: Colors.black),
                    Input(
                        validation: "Re-enter Password required !!",
                        title: "Re-enter Password",
                        border: Colors.black,
                        fill: Colors.white,
                        text: Colors.black),
                    Button(
                        title: ' Sign Up',
                        buttonColor: UI.appColor,
                        textColor: Colors.white,
                        destination: '/root',
                        icon: Icon(Icons.app_registration)),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        'You have an already Account? Log In',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    const SizedBox(
                      height: 70.0,
                    ),
                    Text(
                      "_____________  or _____________",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )
                  ]),
              Container(
                padding: EdgeInsets.all(20),
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    signInWith('assets/icons/google.png'),
                    signInWith('assets/icons/facebook.png')
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
