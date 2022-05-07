import 'package:flutter/material.dart';

import '../utils/app_ui.dart';

class Password extends StatelessWidget {
  final String hintText;

  Password({required this.hintText});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 7,
      width: size.width / 1.25,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        onChanged: (value) => {},
        style: const TextStyle(color: Colors.white, fontSize: 20),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the password';
          } else if (value.length <= 6) {
            return 'Password must be greator than 6 digits';
          }
        },
        obscureText: true,
        decoration: InputDecoration(
          suffixIconColor: Colors.white,
          prefixIcon: Icon(
            Icons.lock_outline,
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
