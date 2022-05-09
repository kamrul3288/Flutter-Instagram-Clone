
import 'package:cloud_firestore/cloud_firestore.dart';
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

String convertTimeStampToReadableTime(Timestamp timestamp){
  var result = "";
  final previous = DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
  final now = DateTime.now();
  final difference = now.difference(previous);
  if(difference.inSeconds<60){
    result = "${difference.inSeconds} sec ago";
    return result;
  }
  if(difference.inMinutes<60){
    result = "${difference.inMinutes} min ago";
    return result;
  }
  if(difference.inHours<24){
    result = "${difference.inHours} hour ago";
    return result;
  }
  result = "${difference.inDays} days ago";
  return result;

}