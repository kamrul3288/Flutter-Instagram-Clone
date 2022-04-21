
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_instagram_clone/utils/app_config.dart';
import 'package:flutter_instagram_clone/utils/app_constants.dart';

class SignUpViewModel{
  final _auth  = FirebaseAuth.instance;
  final _database = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;


  Future<String> signUp({
    required String name,
    required String email,
    required quote,
    required String password,
    required Uint8List profileImage
  })async{
    var result = "Unknown error occurred";
    try{
      final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if(credential.user != null){

        final storageRef =_storage.ref().child(databaseStorageUserPath).child("${credential.user!.uid}.png");
        UploadTask uploadTask = storageRef.putData(profileImage);
        TaskSnapshot taskSnapshot = await uploadTask;
        final profileImageUrl = await taskSnapshot.ref.getDownloadURL();

        _database.collection(databaseUserPath).doc(credential.user!.uid).set({
          "user_name":name,
          "email":email,
          "quote":quote.isEmpty ? "I am new user":quote,
          "profile_image_url":profileImageUrl,
          "joined_at":DateTime.now(),
          "followers":[],
          "following":[]
        });
        result = resultSuccess;
      }
    }catch(e){
      result = e.toString();
    }
    return result;
  }
}