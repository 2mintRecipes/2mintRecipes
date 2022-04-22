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
      height: 40,
      width: 250,
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        style: TextStyle(fontSize: 15),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validation;
          }
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: border)),
          labelText: title,
          fillColor: fill,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
