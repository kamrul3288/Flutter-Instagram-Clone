import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/viewmodel/user_provider_viewmodel.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserProviderViewModel>(context).getDatabaseUser;
    return  Scaffold(
      body: Center(
        child: Text(userData.userName),
      ),
    );
  }
}
