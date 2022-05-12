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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                              Input(
                                icon: Icons.badge_outlined,
                                hintText: 'Fullname',
                                isPassword: false,
                                isEmail: false,
                                textController: TextEditingController(),
                              ),
                              Input(
                                icon: Icons.account_circle_outlined,
                                hintText: 'Username',
                                isPassword: false,
                                isEmail: false,
                                textController: TextEditingController(),
                              ),
                              Input(
                                  icon: Icons.email_outlined,
                                  hintText: 'Email',
                                  isPassword: false,
                                  isEmail: true,
                                  textController: emailController),
                              Password(hintText: "Password"),
                              Password(hintText: "Re-enter Password"),
                              Button(
                                title: ' Sign Up',
                                buttonColor: UI.appColor,
                                textColor: Colors.white,
                                destination: '/root',
                                icon: const Icon(Icons.app_registration),
                                onTap: () {},
                              )
                            ],
                          ),
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
