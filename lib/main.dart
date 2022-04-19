import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/presenter/login/login_screen.dart';
import 'package:flutter_instagram_clone/resources/color_manager.dart';
import 'package:flutter_instagram_clone/resources/font_manager.dart';
import 'package:flutter_instagram_clone/resources/text_style_manager.dart';
import 'package:flutter_instagram_clone/resources/values_manager.dart';

const bool darkModeEnabled = false;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCojrKj79xoxBC_zSHyTOkxDLaVJ_Jdsq8",
          appId: "1:173130555371:web:06980b13421287ebd083ae",
          messagingSenderId: "173130555371",
          projectId: "flutter-example-6ef48",
          storageBucket: "flutter-example-6ef48.appspot.com"
      )
    );
  }else{
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      title: 'Instagram Clone',
      theme: darkModeEnabled ? ThemeData.dark().copyWith(
        scaffoldBackgroundColor: ColorManager.mobilePlatformBgColor,
        //edit text
        inputDecorationTheme:  InputDecorationTheme(
          labelStyle: regularTextStyle(fontSize: FontSize.s14,color: Colors.white70),
          focusedBorder:const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(AppPadding.p8))
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(AppPadding.p8))
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
        ),
      )
      :ThemeData.light().copyWith(scaffoldBackgroundColor: ColorManager.white),

      home: const LoginScreen(),
      /*home: const ResponsiveLayout(
        mobileView: MobileScreenLayout(),
        webView: WebScreenLayout(),
      ),*/
    );
  }
}


class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();
}