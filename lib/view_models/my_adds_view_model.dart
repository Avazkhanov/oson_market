import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oson_market/data/models/products_model.dart';
import 'package:oson_market/utils/constants/app_constants.dart';
import 'package:oson_market/utils/utility_function.dart';

class MyAddsViewModel extends ChangeNotifier {
  MyAddsViewModel({required this.userID}){
    getUserProducts(userID);
  }
  final String userID;

  bool isLoading = false;
  List<ProductModel> products = [];

  Future<List<ProductModel>> getUserProducts(String userID) async {
    print("loading");
    await FirebaseFirestore.instance
        .collection(AppConstants.products)
        .where("user_id", isEqualTo: userID)
        .get()
        .then((snapshot) {
      products =
          snapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
      print(products);
    });
    return products;
  }

  updateProduct(ProductModel productModel, BuildContext context) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.products)
          .doc(productModel.docId)
          .update(productModel.toJsonForUpdate());

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSneckbar(
        context: context,
        message: error.code,
      );
    }
  }

  deleteProduct(String docId, BuildContext context) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.products)
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
    getUserProducts(userID);
  }

  _notify(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
