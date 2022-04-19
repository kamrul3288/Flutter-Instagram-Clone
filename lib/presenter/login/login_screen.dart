import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/resources/color_manager.dart';
import 'package:flutter_instagram_clone/resources/font_manager.dart';
import 'package:flutter_instagram_clone/resources/icon_manager.dart';
import 'package:flutter_instagram_clone/resources/text_style_manager.dart';
import 'package:flutter_instagram_clone/resources/values_manager.dart';
import 'package:flutter_instagram_clone/utils/navigator_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //icon
                Center(
                  child: SvgPicture.asset(IconManager.ic_instagram,width: 100,),
                ),

                //title
                const SizedBox(height: AppMargin.m48,),
                Text("Welcome back!",style: boldTextStyle(fontSize: FontSize.s18),),

                //sub title
                const SizedBox(height: AppMargin.m8,),
                Text("Sign in to your account",style: lightTextStyle(letterSpacing: 0.5),),

                //email input field
                const SizedBox(height: AppMargin.m48,),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label:Text("Enter your email")
                  ),
                ),

                //password input field
                const SizedBox(height: AppMargin.m16,),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label:Text("Enter your password")
                  ),
                ),


                //sign in button
                const SizedBox(height: AppMargin.m48,),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: (){},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(ColorManager.instagramColor1),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppMargin.m8)
                        ),
                      ),
                    ),
                    child: const Text("Sign In"),
                  ),
                ),

                //signup text and button
                const SizedBox(height: AppMargin.m36,),
                InkWell(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Don't have an account? Sign Up",
                      style: regularTextStyle(fontSize: FontSize.s16,letterSpacing: 0.7),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: ()=>context.push(screenName: signupScreenObject)
                )
              ],
            ),
          ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.clear();
    _passwordController.clear();
  }
}
