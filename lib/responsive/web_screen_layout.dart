import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/presenter/addpost/add_post_screen.dart';
import 'package:flutter_instagram_clone/presenter/bookmark/book_mark_screen.dart';
import 'package:flutter_instagram_clone/presenter/profile/profile_screen.dart';
import 'package:flutter_instagram_clone/presenter/search/search_screen.dart';
import 'package:flutter_instagram_clone/viewmodel/user_provider_viewmodel.dart';
import 'package:provider/provider.dart';

import '../presenter/feed/feed_list_screen.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {

  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  List<Widget> _homeScreenItems(BuildContext context) => [
    const FeedListScreen(),
    const SearchScreen(),
    const AddPostScreen(),
    const BookMarkScreen(),
    ProfileScreen(userId: Provider.of<UserProviderViewModel>(context,listen: false).getDatabaseUser.userId),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: ()=>navigationTapped(0),
            icon: Icon(Icons.home,color: _page == 0 ? Colors.red : Colors.grey,),
          ),
          IconButton(
            onPressed: ()=>navigationTapped(1),
            icon: Icon(Icons.search,color: _page == 1 ? Colors.red : Colors.grey,),
          ),
          IconButton(
            onPressed: ()=>navigationTapped(2),
            icon: Icon(Icons.add_circle,color: _page == 2 ? Colors.red : Colors.grey,),
          ),
          IconButton(
            onPressed: ()=>navigationTapped(3),
            icon: Icon(Icons.bookmarks,color: _page == 3 ? Colors.red : Colors.grey,),
          ),
          IconButton(
            onPressed: ()=>navigationTapped(4),
            icon: Icon(Icons.account_circle,color: _page == 4 ? Colors.red : Colors.grey,),
          )
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        children: _homeScreenItems(context),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
    );
  }
}
