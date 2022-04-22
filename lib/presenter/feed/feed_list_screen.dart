import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/resources/color_manager.dart';
import 'package:flutter_instagram_clone/resources/font_manager.dart';
import 'package:flutter_instagram_clone/resources/text_style_manager.dart';
import 'package:flutter_instagram_clone/resources/values_manager.dart';
import 'package:flutter_instagram_clone/utils/app_config.dart';


class FeedListScreen extends StatefulWidget {
  const FeedListScreen({Key? key}) : super(key: key);

  @override
  State<FeedListScreen> createState() => _FeedListScreenState();
}

class _FeedListScreenState extends State<FeedListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feed"),
      ),
      body: SafeArea(
       child: StreamBuilder(
         stream: FirebaseFirestore.instance.collection(databasePostPath).snapshots(),
         builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot){
           if(snapshot.connectionState == ConnectionState.waiting){
             return const Center(child: CircularProgressIndicator(),);
           }
           return snapshot.data!.docs.isEmpty ?
           const Center(
             child: Text("Opps!, No Feeds found!"),
           )
           :ListView.builder(
             padding: const EdgeInsets.all(AppMargin.m16),
             itemCount: snapshot.data!.docs.length,
             itemBuilder: (context,index){
               final data = snapshot.data!.docs[index];
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
                             backgroundImage: NetworkImage(data['profile_image_url']),
                           ),

                           // user name
                           const SizedBox(width: AppMargin.m8,),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children:  [
                               Text(data['user_name'],style: boldTextStyle(fontSize: FontSize.s14),),
                               Text("15 min ago",style: lightTextStyle(),)
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
                       data['post_url'],
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
                           const Icon(Icons.favorite,color: Colors.grey,),
                           const SizedBox(width: AppMargin.m4,),
                           Text("0 likes",style: regularTextStyle(),),

                           //comment
                           const SizedBox(width: AppMargin.m16,),
                           const Icon(Icons.comment,color: Colors.grey,),
                           const SizedBox(width: AppMargin.m4,),
                           Text("3",style: regularTextStyle(),),
                         ],
                       ),

                       const Icon(Icons.bookmark_border,color: Colors.grey,),
                     ],
                   ),

                   //post description
                   const SizedBox(height: AppMargin.m8,),
                   Text(
                     data['description'],
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


