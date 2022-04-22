import 'package:flutter/material.dart';
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

  static const List<Widget> _bottomNavigationScreen = [
    Text("Home"),
    Text("Search"),
    Text("Add Post"),
    Text("Favourite"),
    Text("Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserProviderViewModel>(context).getDatabaseUser;
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
