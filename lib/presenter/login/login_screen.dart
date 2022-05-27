import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/main.dart';
import 'package:flutter_instagram_clone/presenter/login/login_view_model.dart';
import 'package:flutter_instagram_clone/resources/color_manager.dart';
import 'package:flutter_instagram_clone/resources/font_manager.dart';
import 'package:flutter_instagram_clone/resources/icon_manager.dart';
import 'package:flutter_instagram_clone/resources/text_style_manager.dart';
import 'package:flutter_instagram_clone/resources/values_manager.dart';
import 'package:flutter_instagram_clone/utils/app_constants.dart';
import 'package:flutter_instagram_clone/utils/common_utility_extension.dart';
import 'package:flutter_instagram_clone/utils/navigator_extension.dart';
import 'package:flutter_instagram_clone/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  final _viewModel = LoginViewModel();
  var _isLoading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _loginUser()async{
    _setProgressbarStatus(true);
    final result = await _viewModel.loginUser(
        email: _emailController.toText(),
        password: _passwordController.toText()
    );
    _setProgressbarStatus(false);
    if(result == resultSuccess){
      showToastMessage("You are successfully logged in");
      NavigationService.navigatorKey.currentContext!.pushAndRemoveUntil(screenName: responsiveLayoutScreenObject);
    }else{
      showToastMessage(result);
    }
  }

  _setProgressbarStatus(bool status){
    setState(() {
      _isLoading = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: _isLoading ? const CircularProgressIndicator() : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  //check it web or mobile version

                  padding: MediaQuery.of(context).size.width>PlatformSize.webScreenSze?
                  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/3,vertical: 16)
                  :const EdgeInsets.all(AppPadding.p16),
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
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label:Text("Enter your email")
                        ),
                        validator: (value){
                          return value?.isEmpty==true ? "Please enter valid email" : null;
                        },
                      ),

                      //password input field
                      const SizedBox(height: AppMargin.m16,),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label:Text("Enter your password")
                        ),
                        validator: (value){
                          return value?.isEmpty==true || (value?.length??1) < 5? "Password length must be 6 character" : null;
                        },
                      ),


                      //sign in button
                      const SizedBox(height: AppMargin.m48,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: (){
                            if(_formKey.currentState?.validate() != true) return;
                            _loginUser();
                          },
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
