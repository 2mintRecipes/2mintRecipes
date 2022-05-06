// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../app_ui.dart';

class Input extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final bool isPassword;
  final bool isEmail;
  final TextEditingController textController;

  Input(
      {required this.icon,
      required this.hintText,
      required this.isPassword,
      required this.isEmail,
      required this.textController});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 7,
      width: size.width / 1.25,
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: textController,
        style: TextStyle(color: Colors.white, fontSize: 20),
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(.5),
            size: 30,
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: "  " + hintText,
          hintStyle: TextStyle(
            fontSize: 20,
            color: Colors.white.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
