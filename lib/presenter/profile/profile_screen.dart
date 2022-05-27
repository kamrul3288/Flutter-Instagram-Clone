import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/base/di_get_it.dart';
import 'package:flutter_instagram_clone/model/user_model.dart';
import 'package:flutter_instagram_clone/model/user_post.dart';
import 'package:flutter_instagram_clone/presenter/comment/comment_screen.dart';
import 'package:flutter_instagram_clone/presenter/feed/feed_list_viewmodel.dart';
import 'package:flutter_instagram_clone/presenter/profile/profile_viewmodel.dart';
import 'package:flutter_instagram_clone/resources/color_manager.dart';
import 'package:flutter_instagram_clone/resources/font_manager.dart';
import 'package:flutter_instagram_clone/resources/text_style_manager.dart';
import 'package:flutter_instagram_clone/resources/values_manager.dart';
import 'package:flutter_instagram_clone/utils/app_config.dart';
import 'package:flutter_instagram_clone/utils/navigator_extension.dart';
import 'package:flutter_instagram_clone/utils/utils.dart';
import 'package:flutter_instagram_clone/viewmodel/user_provider_viewmodel.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;
  const ProfileScreen({Key? key,required this.userId}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final postListViewModel = di<FeedListViewModel>();
  final profileViewModel = di<ProfileViewModel>();
  var postCount = 0;

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProviderViewModel>(context,listen: false).getDatabaseUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),

      body: SafeArea(
        child: StreamBuilder(

          //fetch user data
          stream: FirebaseFirestore.instance.collection(databaseUserPath).doc(widget.userId).snapshots(),
          builder: (context,AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>userSnapshot){

            //show loading and wait for fetch user data
            if(userSnapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            final user =  UserModel.mapToUserModel(userSnapshot.data!.data()!);

            // fetch user post data
            return StreamBuilder(
              stream: FirebaseFirestore.instance.collection(databasePostPath)
                  .where("user_uid",isEqualTo: user.userId).snapshots(),
              builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot){

                //show loading and wait for fetch user post data
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator(),);
                }

                return Container(
                  padding:  const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [
                          //profile image section
                          CircleAvatar(
                            backgroundImage: NetworkImage(user.profileImageUrl),
                            radius: 30,
                          ),

                          //post section
                          Expanded(
                            child: Column(
                              children: [
                                Text("${snapshot.data!.docs.length}",style: mediumTextStyle(fontSize: 18),),
                                Text("Posts",style: mediumTextStyle(fontSize: 14),)
                              ],
                            ),
                          ),

                          //Followers section
                          Expanded(
                            child: Column(
                              children: [
                                Text("${user.followers.length}",style: mediumTextStyle(fontSize: 18),),
                                Text("Followers",style: mediumTextStyle(fontSize: 14),)
                              ],
                            ),
                          ),

                          //Following section
                          Expanded(
                            child: Column(
                              children: [
                                Text("${user.following.length}",style: mediumTextStyle(fontSize: 18),),
                                Text("Following",style: mediumTextStyle(fontSize: 14),)
                              ],
                            ),
                          )

                        ],
                      ),

                      //profile name section
                      const SizedBox(height: 20,),
                      Text(user.userName,style: mediumTextStyle(fontSize: 16) ,),
                      Text(user.quote,style: mediumTextStyle(fontSize: 13) ,),


                      const SizedBox(height: 16,),
                      Row(
                        children: [

                          //sign out button'
                          currentUser.userId != user.userId ? Container()
                          :Expanded(
                            child:  SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 35,
                              child: ElevatedButton(
                                onPressed: ()async{
                                  if(user.userId == currentUser.userId){
                                    await FirebaseAuth.instance.signOut();
                                    context.pushAndRemoveUntil(screenName: loginScreenObject);
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(ColorManager.instagramColor1),
                                ),
                                child: const Text("Sign out"),
                              ),
                            ),
                          ),

                          //follow button'
                          currentUser.userId == user.userId ? Container()
                          :Expanded(
                            child:  SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 35,
                              child: ElevatedButton(
                                onPressed: (){
                                  if(user.userId != currentUser.userId){
                                    profileViewModel.followOrUnfollow(
                                        userId: user.userId,
                                        followers: user.followers
                                    );
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                ),
                                child: Text(user.followers.contains(currentUser.userId) ? "UnFollow":"Follow"),
                              ),
                            ),
                          )
                        ],
                      ),


                      //post list
                      const SizedBox(height: 16,),
                      Text("Posts",style: mediumTextStyle(fontSize: 20) ,),
                      Expanded(
                        child: snapshot.data!.docs.isEmpty ? const Center(child: Text("Opps!, No Feeds found!"),)
                            :ListView.builder(
                          padding: const EdgeInsets.all(AppMargin.m16),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context,index){
                            final post = Post.mapToPost(snapshot.data!.docs[index].data());
                            return Column(
                              children:  [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        //profile image
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundImage: NetworkImage(post.profileImageUrl),
                                        ),

                                        // user name
                                        const SizedBox(width: AppMargin.m8,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:  [
                                            Text(post.userName,style: boldTextStyle(fontSize: FontSize.s14),),
                                            Text(convertTimeStampToReadableTime(post.datePublished),style: lightTextStyle(),)
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Icon(Icons.more_vert,color: Colors.grey,)
                                  ],
                                ),

                                //post image
                                const SizedBox(height: AppMargin.m8,),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(AppMargin.m8),
                                  child: Image.network(
                                    post.postUrl,
                                    width: MediaQuery.of(context).size.width,
                                    height: 170,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                //post toggle
                                const SizedBox(height: AppMargin.m8,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children:  [
                                        //likes
                                        InkWell(
                                          child: Icon(
                                              Icons.favorite,
                                              color: post.likes.contains(user.userId) ? Colors.red : Colors.grey
                                          ),
                                          onDoubleTap: (){
                                            postListViewModel.likesPost(
                                                postId: post.postId,
                                                userId:user.userId,
                                                likes: post.likes
                                            );
                                          },
                                        ),
                                        const SizedBox(width: AppMargin.m4,),
                                        Text("${post.likes.length} likes",style: regularTextStyle(),),

                                        //comment
                                        const SizedBox(width: AppMargin.m16,),
                                        IconButton(
                                          onPressed: (){
                                            context.push(screenName: CommentScreen(postData: post));
                                          },
                                          icon: const Icon(Icons.comment,color: Colors.grey),
                                        ),
                                        const SizedBox(width: AppMargin.m4,),


                                        StreamBuilder(
                                          stream:  FirebaseFirestore.instance.collection(databasePostPath) .doc(post.postId)
                                              .collection(commentPath).snapshots(),
                                          builder: (context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>commentSnapshot){
                                            if(commentSnapshot.connectionState == ConnectionState.waiting){
                                              return  Text("0 Comments",style: regularTextStyle());
                                            }
                                            return Text("${commentSnapshot.data?.docs.length ?? 0} Comments",style: regularTextStyle());
                                          },
                                        )

                                      ],
                                    ),

                                    //Bookmark or favourite
                                    InkWell(
                                      child:  Icon(Icons.bookmark_border,color: post.bookmarks.contains(user.userId) ? Colors.red : Colors.grey,),
                                      onTap: (){
                                        postListViewModel.bookmarkPost(
                                            postId: post.postId,
                                            userId: user.userId,
                                            bookmarks: post.bookmarks
                                        );
                                      },
                                    ),
                                  ],
                                ),

                                //post description
                                const SizedBox(height: AppMargin.m8,),
                                Text(
                                  post.description,
                                  style: regularTextStyle(fontSize: FontSize.s14,color: ColorManager.dimGray),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                const SizedBox(height: AppMargin.m36,),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        )
      ),

    );
  }
}
