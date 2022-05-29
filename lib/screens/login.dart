import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:x2mint_recipes/screens/root.dart';
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
  SecureStorage secureStorage = SecureStorage();
  AuthClass authClass = AuthClass();
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

  void submit() async {
    var isValid = validate();
    if (!isValid) {
      return;
    }
    await loginWithUsernamePassword();
  }

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
                  // width: MediaQuery.of(context).size.width * 0.9,
                  // height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      loginWithEmailPassword(),
                      loginWithSocialNetwork(),
                      forgotPasswordOrRegister()
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

  Widget loginWithEmailPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
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
          onChanged: onEmailChanged,
          maxLine: 1,
          labelText: "Email",
          errorText: emailError,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autoFocus: true,
          textEditingController: emailController,
        ),
        InputField(
          prefixIcon: Icons.lock,
          onChanged: onPasswordChanged,
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
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget loginWithSocialNetwork() {
    return Column(
      children: [
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
              // signInWith('assets/icons/facebook.png'),
            ],
          ),
        ),
      ],
    );
  }

  Widget forgotPasswordOrRegister() {
    return Container(
      padding: const EdgeInsets.all(10),
      // width: MediaQuery.of(context).size.width * .7,
      child: Column(
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
              var re = await authClass.signInWithGoogle();
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

  Future loginWithUsernamePassword() async {
    var email = emailController.text;
    var password = passwordController.text;
    var isLoggedIn = await authClass.loginWithUsernamePassword(email, password);
    if (isLoggedIn) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Root()),
      );
    }
  }
}
