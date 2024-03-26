import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/data/models/products_model.dart';
import 'package:oson_market/screens/diologs/alert_dialog.dart';
import 'package:oson_market/screens/routes.dart';
import 'package:oson_market/utils/colors/app_colors.dart';
import 'package:oson_market/view_models/auth_view_model.dart';
import 'package:provider/provider.dart';


class MyAdsListItem extends StatelessWidget {
  const MyAdsListItem({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    var user = context.watch<AuthViewModel>().getUser;
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(50.r),
        child: Image.network(
          product.imageUrl,
          height: 50.h,
          width: 50.w,
          fit: BoxFit.fill,
        ),
      ),
      title: Text(product.productName),
      trailing: SizedBox(
        height: 40.h,
        width: 100.w,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                showDeleteAlert(
                    context: context, isLogOut: false, docId: product.docId, useId: user!.uid);
              },
              icon: const Icon(
                CupertinoIcons.delete,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesNames.update,arguments: product);
              },
              icon: const Icon(
                Icons.edit,
                color: AppColors.c_1317DD,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
