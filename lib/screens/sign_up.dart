import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:x2mint_recipes/screens/login.dart';
import 'package:x2mint_recipes/screens/root.dart';
import 'package:x2mint_recipes/services/auth.service.dart';
import 'package:x2mint_recipes/services/seccure_storage.dart';
import 'package:x2mint_recipes/utils/app_ui.dart';
import 'package:x2mint_recipes/widgets/input.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static const routeName = '/signup';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reEnterPasswordController = TextEditingController();
  SecureStorage secureStorage = SecureStorage();
  AuthClass authClass = AuthClass();

  late String fullName, username, email, password, confirmPassword;
  String? fullNameError,
      usernameError,
      emailError,
      passwordError,
      confirmPasswordError;

  @override
  void initState() {
    super.initState();
    fullName = "";
    username = "";
    email = "";
    password = "";
    confirmPassword = "";

    fullNameError = null;
    usernameError = null;
    emailError = null;
    passwordError = null;
    confirmPasswordError = null;
  }

  void resetErrorText() {
    setState(() {
      fullNameError = null;
      usernameError = null;
      emailError = null;
      passwordError = null;
      confirmPasswordError = null;
    });
  }

  bool validate() {
    resetErrorText();

    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    bool isValid = true;

    if (fullName.isEmpty) {
      setState(() {
        fullNameError = "       Please enter a FullName";
      });
      isValid = false;
    }
    if (username.isEmpty) {
      setState(() {
        usernameError = "       Please enter a Username";
      });
      isValid = false;
    }
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
    if (confirmPassword.isEmpty) {
      setState(() {
        confirmPassword = "       Please confirm password";
      });
      isValid = false;
    }
    if (password != confirmPassword) {
      setState(() {
        confirmPasswordError = "       Passwords do not match";
      });
      isValid = false;
    }
    return isValid;
  }

  void submit() {
    if (validate()) {
      {
        //regis ở đây nè :v
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  filterQuality: FilterQuality.low,
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6),
                    BlendMode.darken,
                  ),
                  image: const AssetImage("assets/images/welcome_bg.jpg"),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .25,
                  child: Transform.scale(
                    scale: 0.5,
                    child: Image.asset(UI.appLogo),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                /// SignUp Title
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "SIGN UP",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                                /// FullName
                                InputField(
                                  prefixIcon: Icons.badge,
                                  onChanged: onFullnameChanged,
                                  labelText: "FullName",
                                  errorText: fullNameError,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  autoFocus: true,
                                  textEditingController: fullNameController,
                                ),

                                /// Username
                                InputField(
                                  prefixIcon: Icons.account_circle,
                                  onChanged: onUsernameChanged,
                                  labelText: "Username",
                                  errorText: usernameError,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  autoFocus: true,
                                  textEditingController: usernameController,
                                ),

                                /// Email
                                InputField(
                                  prefixIcon: Icons.alternate_email,
                                  onChanged: onEmailChanged,
                                  labelText: "Email",
                                  errorText: emailError,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  autoFocus: true,
                                  textEditingController: emailController,
                                ),

                                /// Password
                                InputField(
                                  prefixIcon: Icons.lock,
                                  onChanged: onPasswordChanged,
                                  labelText: "Password",
                                  errorText: passwordError,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.next,
                                  autoFocus: true,
                                  textEditingController: passwordController,
                                ),

                                /// Confirm Password
                                InputField(
                                  prefixIcon: Icons.lock,
                                  onChanged: onConfirmPasswordChanged,
                                  labelText: "Confirm Password",
                                  errorText: confirmPasswordError,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.next,
                                  autoFocus: true,
                                  textEditingController:
                                      reEnterPasswordController,
                                ),

                                /// SignUp Button
                                getSignUpButton(),
                              ]),
                          alreadyHaveAccount(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  onUsernameChanged(value) {
    if (usernameError != null) {
      setState(() {
        usernameError = null;
      });
    }
    setState(() {
      username = value;
    });
  }

  onFullnameChanged(value) {
    if (fullNameError != null) {
      setState(() {
        fullNameError = null;
      });
    }
    setState(() {
      fullName = value;
    });
  }

  onEmailChanged(value) {
    if (emailError != null) {
      setState(() {
        emailError = null;
      });
    }
    setState(() {
      email = value;
    });
  }

  onPasswordChanged(value) {
    if (passwordError != null) {
      setState(() {
        passwordError = null;
      });
    }
    setState(() {
      password = value;
    });
  }

  onConfirmPasswordChanged(value) {
    if (confirmPasswordError != null) {
      setState(() {
        confirmPasswordError = null;
      });
    }
    setState(() {
      confirmPassword = value;
    });
  }

  Widget getSignUpButton() {
    return Padding(
      padding: const EdgeInsets.all(10),
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
          icon: const Icon(Icons.app_registration),
          label: const Text(
            "Sign Up",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget alreadyHaveAccount(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          'You already have an account?',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, Login.routeName);
          },
          child: const Text(
            'Log In',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
