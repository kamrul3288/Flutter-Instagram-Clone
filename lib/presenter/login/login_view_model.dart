

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_instagram_clone/utils/app_constants.dart';

class LoginViewModel{
  final _auth = FirebaseAuth.instance;

  loginUser({
    required String email,
    required String password
  })async{
    var result = unknownError;
    try {
      await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      result = resultSuccess;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        result = "No user found for that email";
      } else if (e.code == 'wrong-password') {
        result = "Wrong email or password provided for that user";
      }else{
        result = e.message.toString();
      }
    }
    return result;
  }

}
