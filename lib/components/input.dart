import 'dart:core';

import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField(
      {this.labelText,
      this.onChanged,
      this.onSubmitted,
      this.errorText,
      this.keyboardType,
      this.textInputAction,
      this.autoFocus = false,
      this.obscureText = false,
      this.prefixIcon,
      this.textEditingController,
      Key? key})
      : super(key: key);

  final String? labelText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autoFocus;
  final bool obscureText;
  final IconData? prefixIcon;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(.2),
            borderRadius: BorderRadius.circular(15)),
        child: TextField(
          controller: textEditingController,
          style: const TextStyle(color: Colors.white, fontSize: 20),
          autofocus: autoFocus,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(
              prefixIcon,
              color: Colors.white.withOpacity(.5),
              size: 30,
            ),
            hintStyle: TextStyle(
              fontSize: 20,
              color: Colors.white.withOpacity(.5),
            ),
            border: InputBorder.none,
            hintMaxLines: 1,
            hintText: labelText,
            errorText: errorText,
            errorStyle: TextStyle(
              fontSize: 18,
              color: Colors.red.withOpacity(.5),
            ),
          ),
        ));
  }
}
