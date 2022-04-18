import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/resources/color_manager.dart';
import 'package:flutter_instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:flutter_instagram_clone/responsive/responsive_layout.dart';
import 'package:flutter_instagram_clone/responsive/web_screen_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: ColorManager.mobilePlatformBgColor
      ),
      home: const ResponsiveLayout(
        mobileView: MobileScreenLayout(),
        webView: WebScreenLayout(),
      ),
    );
  }
}

