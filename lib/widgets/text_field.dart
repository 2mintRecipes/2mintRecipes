import 'dart:core';

import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  const TextView({
    this.text,
    this.autoFocus = false,
    this.obscureText = true,
    this.fontSize = 20,
    this.icon,
    this.maxLine,
    this.border,
    this.textEditingController,
    this.color,
    Key? key,
  }) : super(key: key);
  final Color? color;
  final BorderRadius? border;
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
        decoration: BoxDecoration(
          color: ((color == null) ? Colors.black.withOpacity(.2) : color),
          borderRadius: ((border == null) ? BorderRadius.circular(15) : border),
        ),
        child: Row(
          children: [
            (icon == null)
                ? const Padding(
                    padding: EdgeInsets.only(bottom: 5, top: 5),
                    child: SizedBox(
                      height: 30,
                    ))
                : Padding(
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
            SizedBox(
              width: MediaQuery.of(context).size.width -
                  ((icon == null) ? 80 : 120),
              child: Text(
                text!,
                maxLines: maxLine,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ));
  }
}
