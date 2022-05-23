import 'dart:core';

import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    this.labelText,
    this.onChanged,
    this.onSubmitted,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.autoFocus = false,
    this.obscureText = false,
    this.fontSize = 20,
    this.prefixIcon,
    this.textEditingController,
    this.maxLine,
    Key? key,
  }) : super(key: key);

  final String? labelText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autoFocus;
  final bool obscureText;
  final IconData? prefixIcon;
  final int? maxLine;
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
      child: TextField(
        controller: textEditingController,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          overflow: TextOverflow.ellipsis,
        ),
        maxLines: maxLine,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.white.withOpacity(.5),
            size: 30,
          ),
          hintStyle: TextStyle(
            fontSize: 20,
            overflow: TextOverflow.ellipsis,
            color: Colors.white.withOpacity(.5),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorText: errorText,
          errorStyle: TextStyle(
            fontSize: 18,
            color: Colors.red.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
