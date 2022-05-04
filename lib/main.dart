import 'package:flutter/material.dart';
import 'package:flutter_first/Screen/bookmark.dart';
import 'package:flutter_first/Screen/root.dart';
import 'package:flutter_first/Screen/login.dart';
import 'package:flutter_first/Screen/sign_up.dart';
import 'Screen/root.dart';
import 'Screen/welcome.dart';
import 'app_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "2mint Recipes",
        theme: ThemeData(scaffoldBackgroundColor: Colors.transparent),
        home: Welcome(),
        routes: {
          Welcome.routeName: (context) => Welcome(),
          Login.routeName: (context) => Login(),
          SignUp.routeName: (context) => SignUp(),
          Root.routeName: (context) => Root(),
          Bookmark.routeName: (context) => Bookmark()
        });
  }
}
