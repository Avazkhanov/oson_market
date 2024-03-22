import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:oson_market/data/models/products_model.dart';
import 'package:oson_market/screens/my_adds/widgets/my_ads_list_item.dart';
import 'package:oson_market/utils/images/app_images.dart';
import 'package:oson_market/view_models/my_adds_view_model.dart';
import 'package:provider/provider.dart';

class MyAddsScreen extends StatefulWidget {
  const MyAddsScreen({super.key, required this.userId});

  final String userId;

  @override
  State<MyAddsScreen> createState() => _MyAddsScreenState();
}

class _MyAddsScreenState extends State<MyAddsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Adds'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 24.sp),
        ),
      ),
      body: FutureBuilder(
        future: context.watch<MyAddsViewModel>().getUserProducts(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            List<ProductModel> listProducts =
                snapshot.data as List<ProductModel>;
            if (listProducts.isNotEmpty) {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: listProducts.length,
                itemBuilder: (context, index) {
                  var product = listProducts[index];
                  return MyAdsListItem(product: product);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 15.h);
                },
              );
            } else {
              return Center(
                child: LottieBuilder.asset(AppImages.empty),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
