import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/presenter/login/login_screen.dart';
import 'package:flutter_instagram_clone/presenter/signup/sign_up_screen.dart';

const signupScreenObject = SignUpScreen();
const loginScreenObject = LoginScreen();

extension  ScreenNavigation on BuildContext{
  push({required Widget screenName}){
    Navigator.push(
      this,
      MaterialPageRoute(builder: (context){
        return screenName;
      }),
    );
  }

  pushAndRemoveUntil({required Widget screenName}){
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (context){
        return screenName;
      }),(route) => false
    );
  }
 }
