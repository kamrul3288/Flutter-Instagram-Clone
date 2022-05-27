import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/base/di_get_it.dart';
import 'package:flutter_instagram_clone/model/user_post.dart';
import 'package:flutter_instagram_clone/presenter/comment/comment_screen.dart';
import 'package:flutter_instagram_clone/presenter/feed/feed_list_viewmodel.dart';
import 'package:flutter_instagram_clone/resources/color_manager.dart';
import 'package:flutter_instagram_clone/resources/font_manager.dart';
import 'package:flutter_instagram_clone/resources/text_style_manager.dart';
import 'package:flutter_instagram_clone/resources/values_manager.dart';
import 'package:flutter_instagram_clone/utils/app_config.dart';
import 'package:flutter_instagram_clone/utils/navigator_extension.dart';
import 'package:flutter_instagram_clone/utils/utils.dart';
import 'package:flutter_instagram_clone/viewmodel/user_provider_viewmodel.dart';
import 'package:provider/provider.dart';


class FeedListScreen extends StatefulWidget {
  const FeedListScreen({Key? key}) : super(key: key);

  @override
  State<FeedListScreen> createState() => _FeedListScreenState();
}

class _FeedListScreenState extends State<FeedListScreen> {

  final viewModel = di<FeedListViewModel>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProviderViewModel>(context,listen: false).getDatabaseUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feed"),
      ),
      body: SafeArea(
       child: StreamBuilder(
         stream: FirebaseFirestore.instance.collection(databasePostPath)
             .orderBy("date_published",descending: true).snapshots(),
         builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot){
           if(snapshot.connectionState == ConnectionState.waiting){
             return const Center(child: CircularProgressIndicator(),);
           }

           return snapshot.data!.docs.isEmpty ?
           const Center(
             child: Text("Opps!, No Feeds found!"),
           )
           :ListView.builder(
             //check it web or mobile version
             padding: MediaQuery.of(context).size.width>PlatformSize.webScreenSze?
             EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/3.5,vertical: 16)
                 :const EdgeInsets.all(AppPadding.p16),

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
                               viewModel.likesPost(
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
                           viewModel.bookmarkPost(
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
           );
         },
       ),
      ),
    );
  }
}


