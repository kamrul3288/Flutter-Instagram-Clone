

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String userName;
  final String email;
  final String userId;
  final String quote;
  final String profileImageUrl;
  final Timestamp joinedAt;
  final List followers;
  final List following;

  const UserModel({
    required this.userName,
    required this.email,
    required this.userId,
    required this.quote,
    required this.profileImageUrl,
    required this.joinedAt,
    required this.followers,
    required this.following,
  });


  Map<String,dynamic>toJson()=>{
    "user_name":userName,
    "email":email,
    "user_id":userId,
    "quote":quote,
    "profile_image_url":profileImageUrl,
    "joined_at":joinedAt,
    "followers":followers,
    "following":following
  };
}