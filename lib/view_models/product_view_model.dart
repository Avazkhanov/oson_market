import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oson_market/data/api_provider/api_provider.dart';
import 'package:oson_market/data/models/notification_model.dart';
import 'package:oson_market/data/models/products_model.dart';
import 'package:oson_market/services/local_notification_service.dart';
import 'package:oson_market/utils/constants/app_constants.dart';
import 'package:oson_market/utils/utility_function.dart';
import 'package:oson_market/view_models/notification_view_model.dart';
import 'package:provider/provider.dart';

class ProductsViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get getLoader => _isLoading;

  List<ProductModel> categoryProduct = [];

  String? dropdownValue;

  Stream<List<ProductModel>> listenProducts() => FirebaseFirestore.instance
      .collection(AppConstants.products)
      .snapshots()
      .map(
        (event) =>
            event.docs.map((doc) => ProductModel.fromJson(doc.data())).toList(),
      );

  Future<void> getProductsByCategory(String categoryDocId) async {
    _notify(true);
    await FirebaseFirestore.instance
        .collection(AppConstants.products)
        .where("category_id", isEqualTo: categoryDocId)
        .get()
        .then((snapshot) {
      categoryProduct =
          snapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
    });
    _notify(false);
  }


  Future<List<ProductModel>> getPopularProducts() async {
    await FirebaseFirestore.instance
        .collection(AppConstants.products)
        .where("count_views", isGreaterThan: 10)
        .get()
        .then((snapshot) {
      categoryProduct =
          snapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
    });
    return categoryProduct;
  }

  insertProducts(ProductModel productModel, BuildContext context) async {
    try {
      _notify(true);
      var cf = await FirebaseFirestore.instance
          .collection(AppConstants.products)
          .add(productModel.toJson());

      await FirebaseFirestore.instance
          .collection(AppConstants.products)
          .doc(cf.id)
          .update({"doc_id": cf.id});
      if (!context.mounted) return;

      NotificationModel notif = NotificationModel(
        id: DateTime.now().millisecondsSinceEpoch~/10000,
        title: "Added successfully",
        productID: cf.id
      );
      LocalNotificationService.localNotificationService
          .showNotification(
        title: notif.title,
        body: productModel.productName,
        id: notif.id,
        productModel: productModel,
      );
      ApiProvider.sendNotificationToUsers(title: "Added new product! ", body: productModel.productName,topicName: "news");
      context.read<NotificationViewModel>().addToNotification(notif);
      Navigator.pop(context);
      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSneckbar(
        context: context,
        message: error.code,
      );
    }
  }

  updateProduct(
      ProductModel productModel, BuildContext context, bool hasPop) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.products)
          .doc(productModel.docId)
          .update(productModel.toJsonForUpdate());
      if (!context.mounted) return;
      if (hasPop) {
        Navigator.pop(context);
      }
      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSneckbar(
        context: context,
        message: error.code,
      );
    }
  }

  changeValue(String? value) {
    dropdownValue = value;
    notifyListeners();
  }

  _notify(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}
