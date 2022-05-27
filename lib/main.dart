import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/presenter/login/login_screen.dart';
import 'package:flutter_instagram_clone/resources/theme_manager.dart';
import 'package:flutter_instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:flutter_instagram_clone/responsive/responsive_layout.dart';
import 'package:flutter_instagram_clone/responsive/web_screen_layout.dart';
import 'package:flutter_instagram_clone/viewmodel/user_provider_viewmodel.dart';
import 'package:provider/provider.dart';
import 'base/di_get_it.dart' as di;

const bool darkModeEnabled = false;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  di.initializeDependencies();
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> UserProviderViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        title: 'Instagram Clone',
        theme: getApplicationTheme(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.active){
              if(snapshot.hasData){
                return  const ResponsiveLayout(
                  mobileView: MobileScreenLayout(),
                  webView: WebScreenLayout(),
                );
              }else if(snapshot.hasError){
                return  Center(
                  child: Text("${snapshot.error}"),
                );
              }
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}


class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();
}