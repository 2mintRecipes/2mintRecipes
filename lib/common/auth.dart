import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<bool> isLogged() async {
    bool result = false;

    try {
      _firebaseAuth
          .authStateChanges()
          .listen((User? user) => result = user != null);
      return result;
    } catch (e) {
      return false;
    }
  }
}
