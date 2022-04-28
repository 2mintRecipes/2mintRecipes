import 'package:flutter/material.dart';

import '../app_ui.dart';

class Input extends StatelessWidget {
  final String validation;
  final String title;
  final Color border;
  final Color fill;
  final Color text;

  const Input(
      {required this.validation,
      required this.title,
      required this.border,
      required this.fill,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 300,
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        style: TextStyle(fontSize: 20),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validation;
          }
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: border)),
          labelText: title,
          labelStyle: TextStyle(color: UI.appColor),
          fillColor: fill,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
