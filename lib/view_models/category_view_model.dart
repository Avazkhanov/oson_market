import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oson_market/data/models/category_model.dart';
import 'package:oson_market/utils/constants/app_constants.dart';
import 'package:oson_market/utils/utility_function.dart';

class CategoriesViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get getLoader => _isLoading;

  List<CategoryModel> categories = [];

  Future<void> getCategories() async {
    _notify(true);
    await FirebaseFirestore.instance
        .collection(AppConstants.categories)
        .get()
        .then((snapshot) {
      categories =
          snapshot.docs.map((e) => CategoryModel.fromJson(e.data())).toList();
    });
    _notify(false);
  }

  Stream<List<CategoryModel>> listenCategories() => FirebaseFirestore.instance
      .collection(AppConstants.categories)
      .snapshots()
      .map(
        (event) => event.docs
        .map((doc) => CategoryModel.fromJson(doc.data()))
        .toList(),
  );

  insertCategory(CategoryModel categoryModel, BuildContext context) async {
    try {
      _notify(true);
      var cf = await FirebaseFirestore.instance
          .collection(AppConstants.categories)
          .add(categoryModel.toJson());

      await FirebaseFirestore.instance
          .collection(AppConstants.categories)
          .doc(cf.id)
          .update({"doc_id": cf.id});

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSneckbar(
        context: context,
        message: error.code,
      );
    }
  }

  updateCategory(CategoryModel categoryModel, BuildContext context) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.categories)
          .doc(categoryModel.docId)
          .update(categoryModel.toJsonForUpdate());

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSneckbar(
        context: context,
        message: error.code,
      );
    }
  }

  deleteCategory(String docId, BuildContext context) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.categories)
          .doc(docId)
          .delete();

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSneckbar(
        context: context,
        message: error.code,
      );
    }
  }

  _notify(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}