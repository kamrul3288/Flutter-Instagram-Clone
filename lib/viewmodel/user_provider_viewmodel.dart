import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_instagram_clone/base/view_model.dart';
import 'package:flutter_instagram_clone/model/user_model.dart';
import 'package:flutter_instagram_clone/utils/app_config.dart';

class UserProviderViewModel extends ViewModel{

  UserModel? _databaseUserModel;
  UserModel get getDatabaseUser => _databaseUserModel!;

  Future<void> fetchUserData() async{
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection(databaseUserPath)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    final data = documentSnapshot.data() as Map<String,dynamic>;
    _databaseUserModel = UserModel(
        userName: data["user_name"],
        email: data["email"],
        quote: data["quote"],
        profileImageUrl: data["profile_image_url"],
        joinedAt: data["joined_at"],
        followers: data["followers"],
        following: data["following"]
    );
    successfulState();
  }
}