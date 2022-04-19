import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/main.dart';

ThemeData getApplicationTheme(){
  return darkModeEnabled ? _darkTheme() : _lightTheme();
}


ThemeData _darkTheme() {
  return ThemeData.dark();
}

ThemeData _lightTheme() {
  return ThemeData.light();
}


