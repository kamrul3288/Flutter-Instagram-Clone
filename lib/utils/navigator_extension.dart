import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/presenter/login/login_screen.dart';
import 'package:flutter_instagram_clone/presenter/signup/sign_up_screen.dart';
import 'package:flutter_instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:flutter_instagram_clone/responsive/responsive_layout.dart';
import 'package:flutter_instagram_clone/responsive/web_screen_layout.dart';

const signupScreenObject = SignUpScreen();
const loginScreenObject = LoginScreen();
const responsiveLayoutScreenObject = ResponsiveLayout(
    mobileView: MobileScreenLayout(), webView: WebScreenLayout()
);

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
