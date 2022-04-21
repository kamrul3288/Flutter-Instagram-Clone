
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToastMessage(String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: darkModeEnabled ? Colors.white : Colors.black,
      textColor: darkModeEnabled ? Colors.black : Colors.white,
      fontSize: 16.0
  );
}