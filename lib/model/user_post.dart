
import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  final String description;
  final String userUid;
  final String userName;
  final String postId;
  final Timestamp datePublished;
  final String postUrl;
  final String profileImageUrl;
  final List likes;

  const Post({
    required this.description,
    required this.userUid,
    required this.userName,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profileImageUrl,
    required this.likes
  });


  Map<String,dynamic>toJson()=>{
    "description":description,
    "user_uid":userUid,
    "user_name":userName,
    "post_id":postId,
    "date_published":datePublished,
    "post_url":postUrl,
    "profile_image_url":profileImageUrl,
    "likes":likes
  };
}