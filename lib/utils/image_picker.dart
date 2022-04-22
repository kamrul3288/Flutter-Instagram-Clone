import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class AppImagePicker{
  final ImagePicker _picker = ImagePicker();

  Future<Uint8List?> pickImageFromGallery()async{
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image?.readAsBytes();
  }

  Future<Uint8List?> pickProfileImageFromGallery()async{
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery,maxWidth: 500,maxHeight: 500,imageQuality: 70);
    return image?.readAsBytes();
  }

  Future<Uint8List?> pickImageFromCamera()async{
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    return image?.readAsBytes();
  }

  Future<Uint8List?> pickProfileImageFromCamera()async{
    final XFile? image = await _picker.pickImage(source: ImageSource.camera,maxWidth: 500,maxHeight: 500,imageQuality: 70);
    return image?.readAsBytes();
  }

  Future<Uint8List?> pickImage({
    required ImageSource source,
    required double maxWidth,
    required double maxHeight,
    required int imageQuality,
  })async{
    final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality
    );
    return image?.readAsBytes();
  }

}