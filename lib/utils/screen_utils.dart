import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenUtils {
  static void pushScreen({
    required BuildContext context,
    required Widget screen,
  }) {
    ThemeData themeData = Theme.of(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Theme(data: themeData, child: screen),
      ),
    );
  }
}
