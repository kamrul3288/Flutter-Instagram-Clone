import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram_clone/utils/app_config.dart';

class ProfileViewModel{
  final _database = FirebaseFirestore.instance;
  Future<void> followOrUnfollow({
    required String userId,
    required List followers})async{
    try{
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      if(followers.contains(currentUserId)){
        await _database.collection(databaseUserPath).doc(currentUserId).update(
            {'following':FieldValue.arrayRemove([userId])}
        );
        await _database.collection(databaseUserPath).doc(userId).update(
            {'followers':FieldValue.arrayRemove([currentUserId])}
        );

      }else{
        await _database.collection(databaseUserPath).doc(currentUserId).update(
            {'following':FieldValue.arrayUnion([userId])}
        );
        await _database.collection(databaseUserPath).doc(userId).update(
            {'followers':FieldValue.arrayUnion([currentUserId])}
        );
      }
    }catch(exception){
      debugPrint(exception.toString());
    }
  }
}