import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:x2mint_recipes/screens/root.dart';
import 'package:x2mint_recipes/services/seccure_storage.dart';
import 'package:x2mint_recipes/services/auth.service.dart';
import 'package:x2mint_recipes/services/seccure_storage.dart';
import 'package:x2mint_recipes/utils/app_ui.dart';
import 'package:x2mint_recipes/widgets/input.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';
  //final Function(String? email, String? password)? onSubmitted;
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String email, password;
  String? emailError, passwordError;

  @override
  void initState() {
    super.initState();
    email = "";
    password = "";
    emailError = null;
    passwordError = null;
  }

  void resetErrorText() {
    setState(() {
      emailError = null;
      passwordError = null;
    });
  }

  bool validate() {
    resetErrorText();

    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    bool isValid = true;
    if (email.isEmpty) {
      setState(() {
        emailError = "       Please enter a Email";
      });
      isValid = false;
    }
    if (!emailExp.hasMatch(email)) {
      setState(() {
        emailError = "       Email is invalid";
      });
      isValid = false;
    }

    if (password.isEmpty) {
      setState(() {
        passwordError = "       Please enter a password";
      });
      isValid = false;
    }
    return isValid;
  }

  void submit() {
    if (validate()) {
      {
        loginWithUsernamePassword();
      }
    }
  }

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
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Text(
                                "LOG IN",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            InputField(
                              prefixIcon: Icons.alternate_email,
                              onChanged: (value) {
                                if (emailError != null) {
                                  setState(() {
                                    emailError = null;
                                  });
                                }
                                setState(() {
                                  email = value;
                                });
                              },
                              labelText: "Email",
                              errorText: emailError,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              autoFocus: true,
                              textEditingController: emailController,
                            ),
                            InputField(
                              prefixIcon: Icons.lock,
                              onChanged: (value) {
                                if (passwordError != null) {
                                  setState(() {
                                    passwordError = null;
                                  });
                                }
                                setState(() {
                                  password = value;
                                });
                              },
                              onSubmitted: (val) => submit(),
                              labelText: "Password",
                              errorText: passwordError,
                              obscureText: true,
                              textInputAction: TextInputAction.next,
                              textEditingController: passwordController,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: SizedBox(
                                height: 50,
                                child: ElevatedButton.icon(
                                  onPressed: submit,
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: UI.appColor,
                                    shape: RoundedRectangleBorder(
                                      //to set border radius to button
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  icon: const Icon(Icons.login_sharp),
                                  label: const Text(
                                    "Login",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ]),
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * .7,
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
                                Navigator.pushNamed(context, '/forgotPassword');
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
