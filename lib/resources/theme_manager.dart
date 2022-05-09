import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/main.dart';
import 'package:flutter_instagram_clone/resources/color_manager.dart';
import 'package:flutter_instagram_clone/resources/font_manager.dart';
import 'package:flutter_instagram_clone/resources/text_style_manager.dart';
import 'package:flutter_instagram_clone/resources/values_manager.dart';

ThemeData getApplicationTheme(){
  return darkModeEnabled ? _darkTheme() : _lightTheme();
}

// dark theme configuration
ThemeData _darkTheme() {
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: ColorManager.mobilePlatformBgColor,
    //edit text
    inputDecorationTheme:  InputDecorationTheme(
      labelStyle: regularTextStyle(fontSize: FontSize.s14,color: Colors.white70),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(AppPadding.p8))
      ),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(AppPadding.p8))
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
    ),
    bottomNavigationBarTheme:BottomNavigationBarThemeData(
      selectedItemColor: ColorManager.instagramColor1,
      unselectedItemColor: Colors.white38
    )
  );
}

// light theme configuration
ThemeData _lightTheme() {
  return ThemeData.light().copyWith(
    scaffoldBackgroundColor: ColorManager.white,
    //edit text
    inputDecorationTheme:  InputDecorationTheme(
      labelStyle: regularTextStyle(fontSize: FontSize.s14,color: Colors.grey),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(AppPadding.p8))
      ),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(AppPadding.p8))
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.grey,
    ),
    bottomNavigationBarTheme:BottomNavigationBarThemeData(
      selectedItemColor: ColorManager.instagramColor1,
      unselectedItemColor: Colors.grey,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.lightModeAppbarColor,
      elevation: 0,
      titleTextStyle: mediumTextStyle(fontSize: FontSize.s18)
    )
  );
}


