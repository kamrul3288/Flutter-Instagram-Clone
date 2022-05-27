import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/presenter/addpost/add_post_screen.dart';
import 'package:flutter_instagram_clone/presenter/bookmark/book_mark_screen.dart';
import 'package:flutter_instagram_clone/presenter/feed/feed_list_screen.dart';
import 'package:flutter_instagram_clone/presenter/profile/profile_screen.dart';
import 'package:flutter_instagram_clone/presenter/search/search_screen.dart';
import 'package:flutter_instagram_clone/viewmodel/user_provider_viewmodel.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {

  int _bottomNavigationSelectedIndex = 0;

  void _onBottomNavigationItemTapped(int index) {
    setState(() {
      _bottomNavigationSelectedIndex = index;
    });
  }

 List<Widget> _bottomNavigationScreen(BuildContext context) => [
    const FeedListScreen(),
    const SearchScreen(),
    const AddPostScreen(),
    const BookMarkScreen(),
    ProfileScreen(userId: Provider.of<UserProviderViewModel>(context,listen: false).getDatabaseUser.userId),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: _bottomNavigationScreen(context)[_bottomNavigationSelectedIndex],
      ),

      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _bottomNavigationSelectedIndex,
        onTap: _onBottomNavigationItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '',
          ),
        ],
      ),

    );
  }
}
