import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_first/utils/app_ui.dart';

import '../database.dart';

class Account extends StatefulWidget {
  static const routeName = '/bookmark';
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: getAccount(size),
    );
  }
}

Widget getAccount(Size size) {
  return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Padding(
        padding: const EdgeInsets.only(left: 30, top: 20),
        child: Text(
          "Your bookmark",
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        )),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height,
          child: Image.network("https://unsplash.com/photos/bOBM8CB4ZC4"),
        ),
        Center()
      ],
    ),
  ]));
}
