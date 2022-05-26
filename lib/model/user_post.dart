
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
  final List bookmarks;

  const Post({
    required this.description,
    required this.userUid,
    required this.userName,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profileImageUrl,
    required this.likes,
    required this.bookmarks,
  });


  Map<String,dynamic>toJson()=>{
    "description":description,
    "user_uid":userUid,
    "user_name":userName,
    "post_id":postId,
    "date_published":datePublished,
    "post_url":postUrl,
    "profile_image_url":profileImageUrl,
    "likes":likes,
    "bookmarks":bookmarks
  };

  static Post mapToPost(Map<String,dynamic> snapshot){
    return Post(
        description: snapshot["description"],
        userUid: snapshot["user_uid"],
        userName: snapshot["user_name"],
        postId: snapshot["post_id"],
        datePublished: snapshot["date_published"],
        postUrl: snapshot["post_url"],
        profileImageUrl: snapshot["profile_image_url"],
        likes: snapshot["likes"],
        bookmarks: snapshot["bookmarks"]
    );
  }
}