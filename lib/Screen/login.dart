import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:x2mint_recipes/Screen/root.dart';
import 'package:x2mint_recipes/components/button.dart';
import 'package:x2mint_recipes/services/seccure_storage.dart';
import '../utils/app_ui.dart';
import '../components/password.dart';
import '../components/input.dart';
import 'package:x2mint_recipes/components/input.dart';
import 'package:x2mint_recipes/services/auth.service.dart';
import 'package:x2mint_recipes/services/seccure_storage.dart';
import 'package:x2mint_recipes/utils/app_ui.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const routeName = '/login';
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  SecureStorage secureStorage = SecureStorage();
  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  filterQuality: FilterQuality.low,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6),
                    BlendMode.darken,
                  ),
                  image: const AssetImage("assets/images/welcome_bg.jpg"),
                ),
              ),
            ),
          ),
          getBody(),
        ],
      ),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Transform.scale(
              scale: 0.6,
              child: Image.asset(UI.appLogo),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "LOG IN",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Input(
                              icon: Icons.alternate_email_outlined,
                              hintText: 'Email',
                              isPassword: false,
                              isEmail: true,
                              textController: emailController,
                            ),
                            Input(
                              icon: Icons.lock_outline_sharp,
                              hintText: 'Password',
                              isPassword: true,
                              isEmail: false,
                              textController: passwordController,
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                loginWithUsernamePassword();
                                // authClass.googleSignIn(context);
                              },
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: UI.appColor,
                              ),
                              icon: const Icon(Icons.login_sharp),
                              label: const Text("Login"),
                            )
                          ]),
                      Container(
                        padding: const EdgeInsets.only(top: 30),
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/forgot');
                              },
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void loginWithUsernamePassword() {
    var email = emailController.text;
    var password = passwordController.text;

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      // print(value);

      if (value.user != null) {
        secureStorage.writeSecureData('uid', value.user!.uid);
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Root()),
      );
    }).onError((error, stackTrace) {
      print("Error ${error.toString()}");
    });
  }
}
