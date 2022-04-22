import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/base/di_get_it.dart';
import 'package:flutter_instagram_clone/presenter/addpost/add_post_view_model.dart';
import 'package:flutter_instagram_clone/resources/color_manager.dart';
import 'package:flutter_instagram_clone/resources/font_manager.dart';
import 'package:flutter_instagram_clone/resources/text_style_manager.dart';
import 'package:flutter_instagram_clone/resources/values_manager.dart';
import 'package:flutter_instagram_clone/utils/app_constants.dart';
import 'package:flutter_instagram_clone/utils/common_utility_extension.dart';
import 'package:flutter_instagram_clone/utils/image_picker.dart';
import 'package:flutter_instagram_clone/utils/utils.dart';
import 'package:flutter_instagram_clone/viewmodel/user_provider_viewmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _imageFile;
  final _appImagePicker = di<AppImagePicker>();
  final _formKey = GlobalKey<FormState>();
  final _postCaptionController = TextEditingController();
  final viewModel = di<AddPostViewModel>();
  var _isLoading = false;

  
  void _showImagePickerTypeDialog(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            title: const Text("Choose"),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // camera option
                InkWell(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children:  [
                      const Icon(Icons.camera_enhance_sharp),
                      const SizedBox(height: 4,),
                      Text("Camera",style:lightTextStyle(fontSize: FontSize.s16) ,)
                    ],
                  ),
                  onTap: ()=>_pickImage(pickCameraImage),
                ),
                //gallery options
                InkWell(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.image),
                      const SizedBox(height: 4,),
                      Text("Gallery",style: lightTextStyle(fontSize: FontSize.s16),)
                    ],
                  ),
                  onTap: ()=>_pickImage(pickGalleryImage),
                )
              ],
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: ()=>Navigator.of(context).pop()
              ),
            ],
          );
        }
    );
  }

  void _pickImage(String pickedType)async{
    Navigator.of(context).pop();
    final ImageSource source = pickedType == pickGalleryImage ? ImageSource.gallery : ImageSource.camera;
    final imageFile = await _appImagePicker.pickImage(
        source: source,
        maxWidth: 1024, 
        maxHeight: 500,
        imageQuality: 70
    );
    setState(() {
      _imageFile = imageFile;
    });
  }

  _publishPost()async{
    _setProgressbarStatus(true);
    final user = Provider.of<UserProviderViewModel>(context,listen: false).getDatabaseUser;
    final result = await viewModel.publishPost(
        description: _postCaptionController.toText(),
        postImageFile: _imageFile!, 
        userName: user.userName,
        userProfileImageUrl: user.profileImageUrl,
        userUid: user.userId
    );
    if(result == resultSuccess){
      showToastMessage("Your post is posted successfully!");
    }else{
      showToastMessage(result);
    }
    _setProgressbarStatus(false);
    setState(() {
      _imageFile = null;
    });
  }

  _setProgressbarStatus(bool status){
    setState(() {
      _isLoading = status;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProviderViewModel>(context).getDatabaseUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a Post"),
      ),
      body: _isLoading ? const Center(child: CircularProgressIndicator(),)
      :Container(
        padding: const EdgeInsets.all(AppMargin.m16),
        child: _imageFile == null ?
        // only upload icon section
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: const Icon(Icons.upload_rounded),
                onTap: ()=>_showImagePickerTypeDialog(),
              ),
            ],
          ),
        )
        :Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                //profile info
                Row(
                  children:[
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(user.profileImageUrl),
                    ),
                    const SizedBox(width: 8,),
                    Text(user.userName)
                  ],
                ),

                //caption
                const SizedBox(height: AppMargin.m16,),
                TextFormField(
                  controller: _postCaptionController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: "What's on your mind?",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  validator: (value){
                    return value?.isEmpty==true ? "Please add post description" : null;
                  },
                ),

                //picked image
                const SizedBox(height: AppMargin.m16,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppMargin.m16),
                  child: Image.memory(
                    _imageFile!,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),

                //post button
                const SizedBox(height: AppMargin.m36,),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: (){
                      if (!_formKey.currentState!.validate()) return;
                      _publishPost();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(ColorManager.instagramColor1),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppMargin.m8)
                        ),
                      ),
                    ),
                    child: const Text("Posts"),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    super.dispose();
    _postCaptionController.clear();
    _imageFile = null;
  }
}
