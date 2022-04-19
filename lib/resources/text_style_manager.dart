
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/main.dart';
import 'font_manager.dart';

const double _letterSpacing = 0;

TextStyle _getTextStyle(
    double fontSize, String fontFamily, Color color, FontWeight fontWeight,double letterSpacing) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight);
}

TextStyle regularTextStyle({double fontSize = FontSize.s12,
  String fontFamily = FontConstraints.fontFamily,
  Color color =  darkModeEnabled ? Colors.white : Colors.black,
  FontWeight fontWeight = FontWeightManager.regular,
  double letterSpacing = _letterSpacing,
}) {
  return _getTextStyle(fontSize, fontFamily, color, fontWeight,letterSpacing);
}

TextStyle lightTextStyle({double fontSize = FontSize.s12,
  String fontFamily = FontConstraints.fontFamily,
  Color color =  darkModeEnabled ? Colors.white : Colors.black,
  FontWeight fontWeight = FontWeightManager.light,
  double letterSpacing = _letterSpacing,
}) {
  return _getTextStyle(fontSize, fontFamily, color, fontWeight,letterSpacing);
}

TextStyle mediumTextStyle({double fontSize = FontSize.s12,
  String fontFamily = FontConstraints.fontFamily,
  Color color =  darkModeEnabled ? Colors.white : Colors.black,
  FontWeight fontWeight = FontWeightManager.medium,
  double letterSpacing = _letterSpacing,
}) {
  return _getTextStyle(fontSize, fontFamily, color, fontWeight,letterSpacing);
}

TextStyle semiBoldTextStyle({double fontSize = FontSize.s12,
  String fontFamily = FontConstraints.fontFamily,
  Color color =  darkModeEnabled ? Colors.white : Colors.black,
  FontWeight fontWeight = FontWeightManager.semiBold,
  double letterSpacing = _letterSpacing,
}) {
  return _getTextStyle(fontSize, fontFamily, color, fontWeight,letterSpacing);
}

TextStyle boldTextStyle({double fontSize = FontSize.s12,
  String fontFamily = FontConstraints.fontFamily,
  Color color =  darkModeEnabled ? Colors.white : Colors.black,
  FontWeight fontWeight = FontWeightManager.bold,
  double letterSpacing = _letterSpacing,
}) {
  return _getTextStyle(fontSize, fontFamily, color, fontWeight,letterSpacing);
}