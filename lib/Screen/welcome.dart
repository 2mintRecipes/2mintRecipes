// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/Screen/login.dart';
import 'package:flutter_first/Screen/sign_up.dart';
import '../app_ui.dart';
import '../components/button.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);
  static const routeName = '/welcome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    filterQuality: FilterQuality.low,
                    fit: BoxFit.fitHeight,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.darken),
                    image: AssetImage("images/welcome_bg.jpg"))),
            child: Column(children: [
              Expanded(child: Container()),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    Text("Let's",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Anton',
                            fontSize: 60)),
                    Text("Cooking",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Anton',
                            fontSize: 60)),
                    Text("Find the best recipe for today now...",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    Button(
                        title: "Start now ",
                        buttonColor: UI.appColor,
                        textColor: Colors.white,
                        destination: "/login",
                        icon: Icon(Icons.arrow_forward)),
                  ]))
            ])));
  }
}
