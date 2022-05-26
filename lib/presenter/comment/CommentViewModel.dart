

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram_clone/model/PostComment.dart';
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
        final postComment = PostComment(
            userId: userId,
            userName: userName,
            profileImageUrl:
            profileImageUrl,
            comment: comment,
            datePublished: Timestamp.now()
        );
        await _database.collection(databasePostPath).doc(postId).collection(commentPath)
            .doc(commentId).set(postComment.toJson());
      }
    }catch(exception){
      exception.toString();
    }
  }
}