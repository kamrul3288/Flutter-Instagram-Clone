import 'package:flutter/material.dart';


class ColorManager{
  static Color mobilePlatformBgColor = HexColor.fromHex("#1C1C1C");
  static Color webPlatformBgColor = HexColor.fromHex("#1C1C1C");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color black = HexColor.fromHex("#000000");
  static Color instagramColor1 = HexColor.fromHex("#E13022");

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