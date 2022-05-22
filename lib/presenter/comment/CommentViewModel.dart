

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram_clone/utils/app_config.dart';
import 'package:uuid/uuid.dart';

class CommentViewModel{
  final _database = FirebaseFirestore.instance;

  Future<void> postComment({
    required String postId,
    required String comment,
    required String userId,
    required String userName,
    required String profileImageUrl,
  })async{
    try{
      if(comment.isNotEmpty){
        String commentId = const Uuid().v1();
        await _database.collection(databasePostPath).doc(postId).collection(commentPath)
        .doc(commentId).set({
          "profile_image_url" : profileImageUrl,
          "user_name" : userName,
          "user_id" : userId,
          "comment" : comment,
          "data_published" : Timestamp.now(),
        });
      }
    }catch(exception){
      exception.toString();
    }
  }
}