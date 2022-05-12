import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:x2mint_recipes/Screen/welcome.dart';
import 'package:x2mint_recipes/services/auth.service.dart';
import 'firebase_options.dart';
import 'package:x2mint_recipes/Screen/bookmark.dart';
import 'package:x2mint_recipes/Screen/root.dart';
import 'package:x2mint_recipes/Screen/login.dart';
import 'package:x2mint_recipes/Screen/sign_up.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthClass authClass = AuthClass();
  Widget currentPage = const Welcome();

  @override
  void initState() {
    super.initState();
    // currentPage = const Welcome();
    checkLogin();
  }

  checkLogin() async {
    String? token = await authClass.getToken();

    setState(() {
      currentPage = token != null ? const Root() : const Login();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "2mint Recipes",
      theme: ThemeData(scaffoldBackgroundColor: Colors.transparent),
      home: currentPage,
      routes: {
        Welcome.routeName: (context) => const Welcome(),
        Login.routeName: (context) => const Login(),
        SignUp.routeName: (context) => const SignUp(),
        Root.routeName: (context) => const Root(),
        Bookmark.routeName: (context) => const Bookmark(),
      },
    );
  }
}
