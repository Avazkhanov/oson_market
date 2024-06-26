import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImageViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get getLoader => _isLoading;

  Future<String> uploadAndGetImageUrl(File file, String filename) async {
    String imageUrl = '';

    final storageRef = FirebaseStorage.instance.ref();

    final mountainsRef = storageRef.child(filename);


    final mountainImagesRef = storageRef.child("images/$filename");
    try {
      _notify(true);
      await mountainsRef.putFile(file);
    } on FirebaseException catch (e) {
      debugPrint("ERROR:${e.message}");
    }
    imageUrl = await mountainImagesRef.getDownloadURL();
    _notify(false);
    return imageUrl;
  }

  Future<String> uploadImage({required XFile pickedFile, required String storagePath}) async {
    try {

      var ref = FirebaseStorage.instance.ref().child(storagePath);
      _notify(true);
      File file = File(pickedFile.path);

      var uploadTask = await ref.putFile(file);

      String downloadUrl = await uploadTask.ref.getDownloadURL();

      _notify(false);
      return downloadUrl;
    } on FirebaseException catch (error) {
      throw Exception();
    }
  }
  Future<void> deleteImage(String imageUrl) async {
    try {
      var ref = FirebaseStorage.instance.refFromURL(imageUrl);
      await ref.delete();
    } catch (error) {
      throw Exception();
    }
  }



  _notify(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}