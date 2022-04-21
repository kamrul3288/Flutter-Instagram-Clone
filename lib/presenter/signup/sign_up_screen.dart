import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/main.dart';
import 'package:flutter_instagram_clone/presenter/signup/sign_up_view_model.dart';
import 'package:flutter_instagram_clone/resources/color_manager.dart';
import 'package:flutter_instagram_clone/resources/font_manager.dart';
import 'package:flutter_instagram_clone/resources/text_style_manager.dart';
import 'package:flutter_instagram_clone/resources/values_manager.dart';
import 'package:flutter_instagram_clone/utils/app_constants.dart';
import 'package:flutter_instagram_clone/utils/common_utility_extension.dart';
import 'package:flutter_instagram_clone/utils/image_picker.dart';
import 'package:flutter_instagram_clone/utils/navigator_extension.dart';
import 'package:flutter_instagram_clone/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _appImagePicker = AppImagePicker();
  final _formKey = GlobalKey<FormState>();
  Uint8List? _imageFile;
  final _viewModel = SignUpViewModel();
  var _isLoading = false;


  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _quoteController = TextEditingController();
  final _passwordController = TextEditingController();



  void _pickImage()async{
    final image = await _appImagePicker.pickProfileImageFromGallery();
    if(image != null){
      setState(() {
        _imageFile = image;
      });
    }
  }

  void _signUpUser()async{
    _setProgressbarStatus(true);
    final result = await _viewModel.signUp(
        name: _fullNameController.toText(),
        email: _emailController.toText(),
        quote: _quoteController.toText(),
        password: _passwordController.toText(),
        profileImage: _imageFile!
    );
    _setProgressbarStatus(false);
    if(result == resultSuccess){
      showToastMessage("Account successfully created. Login now!");
      NavigationService.navigatorKey.currentContext!.pushAndRemoveUntil(screenName: loginScreenObject);
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
                padding: const EdgeInsets.all(AppPadding.p16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //title
                    const SizedBox(height: AppMargin.m48,),
                    Text("Create new account",style: boldTextStyle(fontSize: FontSize.s18),),

                    //message
                    const SizedBox(height: AppMargin.m8,),
                    Text("Please fill in the form to create account",style: lightTextStyle(letterSpacing: 0.5),),

                    //profile image
                    const SizedBox(height: AppMargin.m48,),
                     Center(
                      child: InkWell(
                        child: _imageFile == null ? const CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 50,
                          child: Center(
                            child: Icon(Icons.camera,color: Colors.black54,),
                          ),
                        )
                        //picked profile image
                        :CircleAvatar(
                        backgroundImage: MemoryImage(_imageFile!),
                        radius: 50,
                      ),
                        onTap: ()=>_pickImage()
                        ,
                      ),
                    ),

                    //name input field
                    const SizedBox(height: AppMargin.m48,),
                    TextFormField(
                      controller: _fullNameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label:Text("Enter full name")
                      ),
                      validator: (value){
                        return value?.isEmpty==true ? "Please enter your beautiful name" : null;
                      },
                    ),

                    //email input field
                    const SizedBox(height: AppMargin.m16,),
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

                    //favourite quote
                    const SizedBox(height: AppMargin.m16,),
                    TextFormField(
                      controller: _quoteController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label:Text("Enter your quote")
                      ),
                    ),

                    //password
                    const SizedBox(height: AppMargin.m16,),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label:Text("Enter your password")
                      ),
                      validator: (value){
                        return value?.isEmpty==true || (value?.length??1) < 5? "Password length must be 6 character" : null;
                      },
                    ),

                    //sign up button
                    const SizedBox(height: AppMargin.m48,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: (){
                          if(_formKey.currentState?.validate() != true) return;
                          if(_imageFile == null){
                            showToastMessage("Please upload your profile picture");
                            return;
                          }
                          _signUpUser();
                        },
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
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.clear();
    _fullNameController.clear();
    _quoteController.clear();
    _passwordController.clear();
  }
}
