// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final Color buttonColor;
  final Color textColor;
  final String destination;
  final Icon icon;
  final Function onTap;

  const Button(
      {required this.title,
      required this.buttonColor,
      required this.textColor,
      required this.destination,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: buttonColor,
              onSurface: Colors.white,
              shape: RoundedRectangleBorder(
                  //to set border radius to button
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () {
            onTap();
            Navigator.pushNamed(context, destination);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: textColor),
              ),
              icon
            ],
          ),
        ),
      ),
    );
  }
}
