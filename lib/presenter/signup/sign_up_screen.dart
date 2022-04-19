import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/resources/color_manager.dart';
import 'package:flutter_instagram_clone/resources/font_manager.dart';
import 'package:flutter_instagram_clone/resources/icon_manager.dart';
import 'package:flutter_instagram_clone/resources/text_style_manager.dart';
import 'package:flutter_instagram_clone/resources/values_manager.dart';
import 'package:flutter_instagram_clone/utils/navigator_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
              //app logo
              Center(
                child: SvgPicture.asset(IconManager.ic_instagram,width: 100,),
              ),

              //title
              const SizedBox(height: AppMargin.m48,),
              Text("Create new account",style: boldTextStyle(fontSize: FontSize.s18),),

              //message
              const SizedBox(height: AppMargin.m8,),
              Text("Please fill in the form to create account",style: lightTextStyle(letterSpacing: 0.5),),

              //name input field
              const SizedBox(height: AppMargin.m48,),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label:Text("Enter full name")
                ),
              ),

              //email input field
              const SizedBox(height: AppMargin.m16,),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label:Text("Enter your email")
                ),
              ),

              //favourite quote
              const SizedBox(height: AppMargin.m16,),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label:Text("Enter your quote")
                ),
              ),

              //password
              const SizedBox(height: AppMargin.m16,),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label:Text("Enter your password")
                ),
              ),

              //sign up button
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
                  child: const Text("Sign Up"),
                ),
              ),

              //login text and button
              const SizedBox(height: AppMargin.m36,),
              InkWell(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Have an account? Sign In",
                    style: regularTextStyle(fontSize: FontSize.s16,letterSpacing: 0.7),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: ()=>context.pushAndRemoveUntil(screenName: loginScreenObject),
              )

            ],
          ),
        ),
      ),
    );
  }
}
