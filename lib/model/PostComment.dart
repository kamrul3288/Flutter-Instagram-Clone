
import 'package:cloud_firestore/cloud_firestore.dart';

class PostComment{
  final String userName;
  final String profileImageUrl;
  final String userId;
  final String comment;
  final Timestamp datePublished;


  PostComment({
    required this.userId,
    required this.userName,
    required this.profileImageUrl,
    required this.comment,
    required this.datePublished,
  });

  Map<String,dynamic>toJson()=>{
    "user_id":userId,
    "user_name":userName,
    "profile_image_url":profileImageUrl,
    "comment":comment,
    "data_published":datePublished
  };

  static PostComment mapToPostComment(Map<String, dynamic> snapshot){
    return PostComment(
      userId: snapshot["user_id"],
      userName: snapshot["user_name"],
      profileImageUrl: snapshot["profile_image_url"],
      comment: snapshot["comment"],
      datePublished: snapshot["data_published"],
    );
  }
}