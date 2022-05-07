import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/Screen/login.dart';
import 'package:flutter_first/Screen/sign_up.dart';
import 'package:flutter_first/components/button.dart';
import '../utils/app_ui.dart';

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
                    image: const AssetImage("images/welcome_bg.jpg"))),
            child: Column(children: [
              Expanded(child: Container()),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    const Text("Let's",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Anton',
                            fontSize: 50)),
                    const Text("Cooking",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Anton',
                            fontSize: 50)),
                    const Text("Find the best recipe for today now...",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    Button(
                      title: "Start now ",
                      buttonColor: UI.appColor,
                      textColor: Colors.white,
                      destination: "/login",
                      icon: const Icon(Icons.arrow_forward),
                      onTap: () {},
                    ),
                  ]))
            ])));
  }
}
