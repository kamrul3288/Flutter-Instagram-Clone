import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/main.dart';
import 'package:flutter_instagram_clone/resources/color_manager.dart';
import 'package:flutter_instagram_clone/resources/text_style_manager.dart';
import 'package:flutter_instagram_clone/utils/app_config.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final _searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //search
              Text("Search Your Mate",style: mediumTextStyle(fontSize: 18),),
              const SizedBox(height: 8,),
              Row(
                children: [
                 Expanded(
                   child:  TextFormField(
                     controller: _searchController,
                     decoration: InputDecoration(
                       filled: true,
                       fillColor: darkModeEnabled ? ColorManager.darkGray : ColorManager.lightModeAppbarColor,
                       hintText: "Search",
                       border: InputBorder.none,
                       focusedBorder: InputBorder.none,
                       enabledBorder: InputBorder.none,
                       errorBorder: InputBorder.none,
                       disabledBorder: InputBorder.none,
                     ),
                     onFieldSubmitted: (value){
                       setState((){
                         _searchController.text = value;
                       });
                     },
                   ),
                 )
                ],
              ),


              //search user list
              Expanded(
                child: FutureBuilder(
                  future: FirebaseFirestore.instance.collection(databaseUserPath)
                      .where('user_name', isGreaterThanOrEqualTo: _searchController.text.toString())
                      .get(),
                  builder: (context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>snapshot){

                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator());
                    }
                    if(!snapshot.hasData){
                      return const Center(child: Text("No Data Found"));
                    }

                    return snapshot.data?.docs.isEmpty == true ?
                    const Center(child: Text("No User Found"))
                    :ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,index){
                          return ListTile(
                            title: Text(snapshot.data!.docs[index]['user_name']),
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(snapshot.data!.docs[index]['profile_image_url']),
                            ),
                          );
                        }
                    );

                  },
                ),
              )
              

            ],
          ),
        ),
      ),
      
    );
  }
}
