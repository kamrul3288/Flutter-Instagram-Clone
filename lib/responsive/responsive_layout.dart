import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/resources/values_manager.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileView;
  final Widget webView;
  const ResponsiveLayout({Key? key,required this.mobileView,required this.webView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        return constraints.maxWidth>PlatformSize.webScreenSze ? webView : mobileView;
      },
    );
  }
}
