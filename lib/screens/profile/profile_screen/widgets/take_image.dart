import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oson_market/view_models/image_view_model.dart';
import 'package:provider/provider.dart';

final ImagePicker picker = ImagePicker();
String imageUrl = "";
String storagePath = "";

Future<String> _getImageFromCamera({required BuildContext context}) async {
  XFile? image = await picker.pickImage(
    source: ImageSource.camera,
    maxHeight: 1024,
    maxWidth: 1024,
  );
  if (image != null && context.mounted) {
    debugPrint("IMAGE PATH:${image.path}");
    storagePath = "files/images/${image.name}";
    imageUrl = await context.read<ImageViewModel>().uploadImage(
          pickedFile: image,
          storagePath: storagePath,
        );
    debugPrint("DOWNLOAD URL:$imageUrl");
    return imageUrl;
  }
  return "";
}

Future<String> _getImageFromGallery({required BuildContext context}) async {
  XFile? image = await picker.pickImage(
    source: ImageSource.gallery,
    maxHeight: 1024,
    maxWidth: 1024,
  );
  if (image != null && context.mounted) {
    debugPrint("IMAGE PATH:${image.path}");
    storagePath = "files/images/${image.name}";
    imageUrl = await context.read<ImageViewModel>().uploadImage(
          pickedFile: image,
          storagePath: storagePath,
        );

    debugPrint("DOWNLOAD URL:$imageUrl");
    return imageUrl;
  }
  return "";
}

takeAnImage(
    {required BuildContext context,
    required isProfilePhoto,
    required VoidCallback callback,
    required ValueChanged<String> url
    }) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    context: context,
    builder: (context) {
      return context.watch<ImageViewModel>().getLoader
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 12.h),
                ListTile(
                  onTap: () async {
                    if (isProfilePhoto) {
                      String photoUrl =
                          await _getImageFromGallery(context: context);
                      var currentUser = FirebaseAuth.instance.currentUser;
                      if (currentUser != null) {
                        await currentUser.updatePhotoURL(photoUrl);
                        callback.call();
                      }
                    }else{
                      url.call(await _getImageFromCamera(context: context));
                    }
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.photo_album_outlined),
                  title: const Text("Get from gallery"),
                ),
                ListTile(
                  onTap: () async {
                    if (isProfilePhoto) {
                      String photoUrl =
                          await _getImageFromCamera(context: context);
                      var currentUser = FirebaseAuth.instance.currentUser;
                      if (currentUser != null) {
                        await context.read<ImageViewModel>().deleteImage(currentUser.photoURL!);
                        await currentUser.updatePhotoURL(photoUrl);
                        callback.call();
                      }
                    }else{
                      url.call(await _getImageFromCamera(context: context));
                    }

                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Get from camera"),
                ),
                SizedBox(height: 24.h),
              ],
            );
    },
  );
}
