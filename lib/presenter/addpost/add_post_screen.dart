import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/base/di_get_it.dart';
import 'package:flutter_instagram_clone/resources/color_manager.dart';
import 'package:flutter_instagram_clone/resources/font_manager.dart';
import 'package:flutter_instagram_clone/resources/text_style_manager.dart';
import 'package:flutter_instagram_clone/resources/values_manager.dart';
import 'package:flutter_instagram_clone/utils/app_constants.dart';
import 'package:flutter_instagram_clone/utils/image_picker.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _imageFile;
  final _appImagePicker = di<AppImagePicker>();

  final _postCaptionController = TextEditingController();


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

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a Post"),
      ),
      body: Container(
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
        :SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              //profile info
              Row(
                children: const [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(width: 8,),
                  Text("Kamran Hasan")
                ],
              ),

              //caption
              TextField(
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
              ),

              //picked image
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
    );
  }
  
  @override
  void dispose() {
    super.dispose();
    _postCaptionController.clear();
    _imageFile = null;
  }
}
