import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/base/di_get_it.dart';
import 'package:flutter_instagram_clone/main.dart';
import 'package:flutter_instagram_clone/presenter/comment/CommentViewModel.dart';
import 'package:flutter_instagram_clone/resources/color_manager.dart';
import 'package:flutter_instagram_clone/resources/text_style_manager.dart';
import 'package:flutter_instagram_clone/utils/app_config.dart';
import 'package:flutter_instagram_clone/utils/common_utility_extension.dart';
import 'package:flutter_instagram_clone/viewmodel/user_provider_viewmodel.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> postData;
  const CommentScreen({Key? key,required this.postData}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {

  final _commentController = TextEditingController();
  final _viewModel = di<CommentViewModel>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProviderViewModel>(context,listen: false).getDatabaseUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comment"),
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16,right: 16),
          child: Row(
            children:  [

              //profile image
              CircleAvatar(
                backgroundImage: NetworkImage(user.profileImageUrl),
                radius: 18,
              ),


              //comment text field
              const SizedBox(width: 16,),
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    hintText: "Comment...",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),

              //comment post button
              const SizedBox(width: 16,),
              TextButton(
                  onPressed:(){
                    _viewModel.postComment(
                        postId: widget.postData["post_id"],
                        comment: _commentController.toText(),
                        userId: user.userId,
                        userName: user.userName,
                        profileImageUrl: user.profileImageUrl
                    );
                  },
                  child: const Text("Post")
              )
            ],
          ),

        ),
      ),


      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection(databasePostPath)
            .doc(widget.postData['post_id']).collection(commentPath).snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return snapshot.data!.docs.isEmpty ?
          const Center(
            child: Text("Opps!, No Comment found!"),
          )
          :ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
              final data = snapshot.data!.docs[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(data['profile_image_url']),
                      radius: 18,
                    ),

                    const SizedBox(width: 4,),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data['user_name'],style: mediumTextStyle(),),
                            Text(data['comment'],style: regularTextStyle(),)
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: darkModeEnabled ? ColorManager.darkGray : ColorManager.lightModeAppbarColor,
                        ),
                      ),
                    )

                  ],
                ),
              );
            },
          );
        },
      )

    );
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.clear();
  }

}
