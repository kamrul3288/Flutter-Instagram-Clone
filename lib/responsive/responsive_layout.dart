import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/base/screen_state.dart';
import 'package:flutter_instagram_clone/resources/values_manager.dart';
import 'package:flutter_instagram_clone/viewmodel/user_provider_viewmodel.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobileView;
  final Widget webView;
  const ResponsiveLayout({Key? key,required this.mobileView,required this.webView}) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  _fetchUserData()async{
    final viewModel = Provider.of<UserProviderViewModel>(context,listen: false);
    await viewModel.fetchUserData();
  }



  @override
  Widget build(BuildContext context) {
/*    return LayoutBuilder(
      builder: (context, constraints){
        return constraints.maxWidth>PlatformSize.webScreenSze ? widget.webView : widget.mobileView;
      },
    );*/
    return Consumer<UserProviderViewModel>(
      builder: (context,viewModel,child){
        if(viewModel.state != ScreenState.success) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(),),
          ) ;
        }
        else {
          return LayoutBuilder(
              builder: (context, constraints){
                return constraints.maxWidth>PlatformSize.webScreenSze ? widget.webView : widget.mobileView;
              }
          );
        }
      },
    );
  }
}


