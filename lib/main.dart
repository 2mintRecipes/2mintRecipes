import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:x2mint_recipes/firebase_options.dart';
import 'package:x2mint_recipes/screens/home/homepage.dart';
import 'package:x2mint_recipes/screens/profile/forgot_password.dart';
import 'package:x2mint_recipes/screens/welcome.dart';
import 'package:x2mint_recipes/services/auth.service.dart';
import 'package:x2mint_recipes/screens/bookmark.dart';
import 'package:x2mint_recipes/screens/root.dart';
import 'package:x2mint_recipes/screens/login.dart';
import 'package:x2mint_recipes/screens/sign_up.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  clientId:
      '530052324208-rb5u4trnudh55i2valn562cd81qnhs91.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

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
  Widget? currentPage; // = const Welcome();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    currentPage = const Welcome();
    checkLogin();
  }

  checkLogin() async {
    // _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
    //   print("============================");
    //   print(account);
    //   setState(() {
    //     _currentUser = account;
    //   });
    //   currentPage = _currentUser != null ? const Root() : const Login();
    // });
    // _googleSignIn.signInSilently();

    String? uid = await authClass.getUid();

    setState(() {
      currentPage = uid != null ? const Root() : const Login();
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
        //HomePage.routeName: (context) => const HomePage(),
        Login.routeName: (context) => const Login(),
        SignUp.routeName: (context) => const SignUp(),
        Root.routeName: (context) => const Root(),
        Bookmark.routeName: (context) => const Bookmark(),
        ForgotPassword.routeName: (context) => const ForgotPassword(),
      },
    );
  }
}
