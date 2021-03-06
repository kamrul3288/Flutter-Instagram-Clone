import 'package:flutter/material.dart';


class ColorManager{
  static Color mobilePlatformBgColor = HexColor.fromHex("#1C1C1C");
  static Color webPlatformBgColor = HexColor.fromHex("#1C1C1C");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color black = HexColor.fromHex("#000000");
  static Color instagramColor1 = HexColor.fromHex("#E13022");
  static Color lightModeAppbarColor = HexColor.fromHex("#F9F9F9");
  static Color dimGray = HexColor.fromHex("#696969");
  static Color darkGray = HexColor.fromHex("#3A3B3C");

}

extension  HexColor on Color{
  static  Color fromHex(String hexColorString){
    hexColorString = hexColorString.replaceAll("#", "");
    if(hexColorString.length == 6){
      hexColorString = "FF"+hexColorString;
    }
    return Color(int.parse(hexColorString,radix: 16));
  }
}