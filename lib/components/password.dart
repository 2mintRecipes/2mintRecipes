import 'package:flutter/material.dart';

import '../app_ui.dart';

class Password extends StatelessWidget {
  const Password({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 250,
      child: TextFormField(
        onChanged: (value) => {},
        style: TextStyle(fontSize: 15),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the password';
          } else if (value.length <= 6) {
            return 'Password must be greator than 6 digits';
          }
        },
        obscureText: true,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.black)),
          labelText: 'Password',
          fillColor: Colors.white,
          filled: true,
          // hintText: 'Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
