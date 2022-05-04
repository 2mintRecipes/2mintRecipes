// ignore_for_file: prefer_const_constructors

import 'dart:ui';

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
                child: Transform.scale(
                    scale: 0.6, child: Image.asset(UI.app_logo)),
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Input(
                                        icon: Icons.badge_outlined,
                                        hintText: 'Fullname',
                                        isPassword: false,
                                        isEmail: false),
                                    Input(
                                        icon: Icons.account_circle_outlined,
                                        hintText: 'Username',
                                        isPassword: false,
                                        isEmail: false),
                                    Input(
                                        icon: Icons.email_outlined,
                                        hintText: 'Email',
                                        isPassword: false,
                                        isEmail: true),
                                    Input(
                                        icon: Icons.lock_outlined,
                                        hintText: 'Password',
                                        isPassword: true,
                                        isEmail: false),
                                    Input(
                                        icon: Icons.lock_outlined,
                                        hintText: 'Re-enter Password',
                                        isPassword: true,
                                        isEmail: false),
                                    Button(
                                        title: ' Sign Up',
                                        buttonColor: UI.appColor,
                                        textColor: Colors.white,
                                        destination: '/root',
                                        icon: Icon(Icons.app_registration))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  child: Text(
                                    'You have an already Account? Log In',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  "_____________  or _____________",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
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
                              ])))),
            ],
          )),
        )
      ],
    ));
  }
}
