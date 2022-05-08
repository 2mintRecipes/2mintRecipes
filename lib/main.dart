import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:x2mint_recipes/Screen/bookmark.dart';
import 'package:x2mint_recipes/Screen/root.dart';
import 'package:x2mint_recipes/Screen/login.dart';
import 'package:x2mint_recipes/Screen/sign_up.dart';
import 'Screen/root.dart';
import 'Screen/welcome.dart';
import 'utils/app_ui.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
        home: const Welcome(),
        routes: {
          Welcome.routeName: (context) => const Welcome(),
          Login.routeName: (context) => const Login(),
          SignUp.routeName: (context) => const SignUp(),
          Root.routeName: (context) => const Root(),
          Bookmark.routeName: (context) => const Bookmark()
        });
  }
}
