// ignore_for_file: prefer_function_declarations_over_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:x2mint_recipes/screens/root.dart';

class AuthClass {
  final storage = const FlutterSecureStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> googleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      if (googleSignInAccount != null) {
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        storeTokenAndData(userCredential);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => const Root()),
          (route) => false,
        );

        print(userCredential.user!.displayName);
        // final snackBar = SnackBar(content: Text(snackbarText));
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print("here---->");
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    // await storage.delete(key: "uid");
    await storage.deleteAll();
  }

  void storeTokenAndData(UserCredential userCredential) async {
    print("storing token and data");
    await storage.write(
        key: "uid", value: userCredential.credential?.token.toString());
    await storage.write(
        key: "usercredential", value: userCredential.toString());
  }

  Future getUid() async {
    //idToken accessToken
    return await storage.read(key: "uid");
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
    await storage.write(key: 'uid', value: googleAuth?.idToken);

    // Once signed in, return the UserCredential
    try {
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> loginWithUsernamePassword(String email, String password) async {
    var value = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    print(value);

    if (value.user != null) {
      await storage.write(key: 'uid', value: value.user!.uid);
      return true;
    }
    return false;
  }

  // Future<void> verifyPhoneNumber(
  //     String phoneNumber, BuildContext context, Function setData) async {
  //   PhoneVerificationCompleted verificationCompleted =
  //       (PhoneAuthCredential phoneAuthCredential) async {
  //     showSnackBar(context, "Verification Completed");
  //   };
  //   PhoneVerificationFailed verificationFailed =
  //       (FirebaseAuthException exception) {
  //     showSnackBar(context, exception.toString());
  //   };
  //   void Function(String verificationID, [int forceResnedingtoken]) codeSent =
  //       (String verificationID, [int? forceResnedingtoken]) {
  //     showSnackBar(context, "Verification Code sent on the phone number");
  //     setData(verificationID);
  //   };

  //   PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
  //       (String verificationID) {
  //     showSnackBar(context, "Time out");
  //   };
  //   try {
  //     await _auth.verifyPhoneNumber(
  //         timeout: const Duration(seconds: 60),
  //         phoneNumber: phoneNumber,
  //         verificationCompleted: verificationCompleted,
  //         verificationFailed: verificationFailed,
  //         codeSent: codeSent,
  //         codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  // }

  Future<void> signInwithPhoneNumber(
      String verificationId, String smsCode, BuildContext context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      storeTokenAndData(userCredential);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (builder) => const Root()),
        (route) => false,
      );

      showSnackBar(context, "logged In");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
