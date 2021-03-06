
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/utils/app_config.dart';

class FeedListViewModel{
  final _database = FirebaseFirestore.instance;

  Future<void> likesPost({
      required String postId,
      required String userId,
      required List likes})async{
    try{
      if(likes.contains(userId)){
        await _database.collection(databasePostPath).doc(postId).update(
          {'likes':FieldValue.arrayRemove([userId])}
        );
      }else{
        await _database.collection(databasePostPath).doc(postId).update(
            {'likes':FieldValue.arrayUnion([userId])}
        );
      }
    }catch(exception){
      debugPrint(exception.toString());
    }
  }

  Future<void> bookmarkPost({
    required String postId,
    required String userId,
    required List bookmarks
  })async{
    try{
      if(bookmarks.contains(userId)){
        await _database.collection(databasePostPath).doc(postId).update(
            {'bookmarks':FieldValue.arrayRemove([userId])}
        );

      }else{
        await _database.collection(databasePostPath).doc(postId).update(
            {'bookmarks':FieldValue.arrayUnion([userId])}
        );
      }
    }catch(exception){
      debugPrint(exception.toString());
    }
  }

  Future<int> getPostComment(String postId) async{
    try{
      QuerySnapshot snapshot = await _database.collection(databasePostPath)
          .doc(postId)
          .collection(commentPath)
          .get();
      return snapshot.docs.length;

    }catch(exception){
      debugPrint(exception.toString());
      return 0;
    }
  }
}