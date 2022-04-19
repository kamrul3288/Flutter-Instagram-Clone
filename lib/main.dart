import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/presenter/login/login_screen.dart';
import 'package:flutter_instagram_clone/resources/theme_manager.dart';

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
      theme: getApplicationTheme(),
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