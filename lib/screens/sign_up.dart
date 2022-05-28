import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:x2mint_recipes/screens/root.dart';
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
                  height: MediaQuery.of(context).size.height * .1,
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
                      height: MediaQuery.of(context).size.height * 0.85,
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

                                /// Username
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

                                /// Email
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

                                /// Password
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

                                /// Confirm Password
                                InputField(
                                  prefixIcon: Icons.lock,
                                  onChanged: (value) {
                                    if (confirmPasswordError != null) {
                                      setState(() {
                                        confirmPasswordError = null;
                                      });
                                    }
                                    setState(() {
                                      confirmPassword = value;
                                    });
                                  },
                                  labelText: "Confirm Password",
                                  errorText: confirmPasswordError,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.next,
                                  autoFocus: true,
                                  textEditingController:
                                      reEnterPasswordController,
                                ),

                                /// SignUp Button
                                Padding(
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
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: const Text(
                              'You have an already Account? Log In',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "_____________  or _____________",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
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
            onPressed: () async {
              var re = await signInWithGoogle();
              if (re != null) {
                Navigator.pushNamed(context, Root.routeName);
              }
            },
            child: const Text(
              'Sign In',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    print(credential);
    secureStorage.writeSecureData('uid', googleAuth?.idToken);

    // Once signed in, return the UserCredential
    try {
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
