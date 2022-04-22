
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_instagram_clone/model/user_post.dart';
import 'package:flutter_instagram_clone/utils/app_config.dart';
import 'package:flutter_instagram_clone/utils/app_constants.dart';
import 'package:uuid/uuid.dart';

class AddPostViewModel{
  final _database = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Future<String> publishPost({
    required String description,
    required Uint8List postImageFile,
    required String userName,
    required userProfileImageUrl,
    required String userUid,
  })async{
    var result = "Unknown error occurred";
    try{
      final storageRef =_storage.ref().child(databaseStoragePostPath).child(userUid).child("${const Uuid().v1()}.png");
      UploadTask uploadTask = storageRef.putData(postImageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      final postImageUrl = await taskSnapshot.ref.getDownloadURL();

      final postId = const Uuid().v1();
      Post post = Post(
          description: description,
          userUid: userUid,
          userName: userName,
          postId: postId,
          datePublished:Timestamp.now(),
          postUrl: postImageUrl,
          profileImageUrl:userProfileImageUrl,
          likes: []
      );
      _database.collection(databasePostPath).doc(postId).set(post.toJson());
      result = resultSuccess;
    }catch(e){
      result = e.toString();
    }
    return result;
  }
}