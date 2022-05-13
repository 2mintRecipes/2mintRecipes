import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:x2mint_recipes/components/button.dart';
import 'package:x2mint_recipes/components/password.dart';
import '../utils/app_ui.dart';
import '../components/input.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static const routeName = '/signup';

  @override
  State<SignUp> createState() => _SignUpState();
}

Widget signInWith(String icon) {
  return Container(
    margin: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.grey.withOpacity(0),
        width: 0,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageIcon(
          AssetImage(icon),
          size: 24,
          color: Colors.white,
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Sign In',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}

class _SignUpState extends State<SignUp> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reEnterPasswordController = TextEditingController();

  late String fullName, username, email, password, reEnterPassword;
  String? fullNameError,
      usernameError,
      emailError,
      passwordError,
      reEnterPasswordError;

  @override
  void initState() {
    super.initState();
    fullName = "";
    username = "";
    email = "";
    password = "";
    reEnterPassword = "";

    fullNameError = null;
    usernameError = null;
    emailError = null;
    passwordError = null;
    reEnterPasswordError = null;
  }

  void resetErrorText() {
    setState(() {
      fullNameError = null;
      usernameError = null;
      emailError = null;
      passwordError = null;
      reEnterPasswordError = null;
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
    if (password != reEnterPassword) {
      setState(() {
        reEnterPasswordError = "       Passwords do not match";
      });
      isValid = false;
    }
    return isValid;
  }

  void submit() {
    if (validate()) {
      {
        //loginWithUsernamePassword(); regis ở đây nè :v
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
                  fit: BoxFit.fitHeight,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 0.6,
                  child: Image.asset(UI.appLogo),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                /// here
                                InputField(
                                  prefixIcon: Icons.badge,
                                  onChanged: (value) {
                                    if (fullNameError != null) {
                                      setState(() {
                                        fullNameError = null;
                                      });
                                    }
                                    setState(() {
                                      fullName = value;
                                    });
                                  },
                                  labelText: "FullName",
                                  errorText: fullNameError,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  autoFocus: true,
                                  textEditingController: fullNameController,
                                ),
                                InputField(
                                  prefixIcon: Icons.account_circle,
                                  onChanged: (value) {
                                    if (usernameError != null) {
                                      setState(() {
                                        usernameError = null;
                                      });
                                    }
                                    setState(() {
                                      username = value;
                                    });
                                  },
                                  labelText: "Username",
                                  errorText: usernameError,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  autoFocus: true,
                                  textEditingController: usernameController,
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
                                  labelText: "Password",
                                  errorText: passwordError,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.next,
                                  autoFocus: true,
                                  textEditingController: passwordController,
                                ),
                                InputField(
                                  prefixIcon: Icons.lock,
                                  onChanged: (value) {
                                    if (reEnterPasswordError != null) {
                                      setState(() {
                                        reEnterPasswordError = null;
                                      });
                                    }
                                    setState(() {
                                      reEnterPassword = value;
                                    });
                                  },
                                  labelText: "Confirm Password",
                                  errorText: reEnterPasswordError,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.next,
                                  autoFocus: true,
                                  textEditingController:
                                      reEnterPasswordController,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      icon: const Icon(Icons.app_registration),
                                      label: const Text(
                                        "Sign Up",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: const Text(
                              'You have an already Account? Log In',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Text(
                            "_____________  or _____________",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            width: 300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                signInWith('assets/icons/google.png'),
                                signInWith('assets/icons/facebook.png'),
                              ],
                            ),
                          )
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
}
