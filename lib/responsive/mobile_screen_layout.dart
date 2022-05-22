import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/presenter/addpost/add_post_screen.dart';
import 'package:flutter_instagram_clone/presenter/feed/feed_list_screen.dart';
import 'package:flutter_instagram_clone/presenter/search/search_screen.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {

  int _bottomNavigationSelectedIndex = 1;

  void _onBottomNavigationItemTapped(int index) {
    setState(() {
      _bottomNavigationSelectedIndex = index;
    });
  }

  static const List<Widget> _bottomNavigationScreen = [
    FeedListScreen(),
    SearchScreen(),
    AddPostScreen(),
    Text("Favourite"),
    Text("Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: _bottomNavigationScreen[_bottomNavigationSelectedIndex],
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
            icon: Icon(Icons.favorite),
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
