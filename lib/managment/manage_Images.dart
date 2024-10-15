import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class imageTemplet {
  String? imagepath;
  String? imageName;
  File? imageFile;
  ImageProvider? image;
  String? imageURL;
  ImageProvider defaultImage;

  imageTemplet({
    this.imagepath,
    this.imageName,
    this.imageFile,
    this.image,
    this.imageURL,
    this.defaultImage = const AssetImage('assets/defaultUser.png'),
  });
}

class manage_Images {
  static ImageProvider defaultImage = const AssetImage('assets/defaultUser.png');

  static imageTemplet takeImageFromDevice(imageTemplet imgTem) {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      imgTem.imagepath = value!.path;
      imgTem.imageName = Uri.file(imgTem.imagepath!).pathSegments.last;
      imgTem.imageFile = File(value.path);
      imgTem.image = Image.file(imgTem.imageFile!).image;
    }).catchError((error) {
      return error;
    });
    return imgTem;
  }

  static ImageProvider? getImageAfterCheck(imageTemplet? imageTemp) {
    if (imageTemp != null && imageTemp.image != null) {
      return imageTemp.image!;
    } else {
      return null;
    }

    // return NetworkImage(ImageLink!);
  }

  static ImageProvider getImageBy_URL(String? URL) {
    if (URL != null && URL.isNotEmpty) {
      return NetworkImage(URL);
    } else {
      return const AssetImage('assets/defaultUser.png');
    }

    // return NetworkImage(ImageLink!);
  }

  static ImageProvider takeImageGallery() {
    ImageProvider? image;

    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      Uri.file(value!.path).pathSegments.last;
      image = Image.file(File(value.path)).image;
    }).catchError((error) {
      return error;
    });
    return image!;
  }
}
