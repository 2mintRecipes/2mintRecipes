import 'dart:core';

import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  const TextView({
    this.text,
    this.autoFocus = false,
    this.obscureText = false,
    this.fontSize = 20,
    this.icon,
    this.maxLine,
    this.textEditingController,
    Key? key,
  }) : super(key: key);

  final String? text;
  final int? maxLine;
  final bool autoFocus;
  final bool obscureText;
  final IconData? icon;
  final double? fontSize;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(left: 30, right: 30, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Icon(
                icon,
                color: Colors.white.withOpacity(.5),
                size: 30,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text!,
              maxLines: maxLine,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ));
  }
}
