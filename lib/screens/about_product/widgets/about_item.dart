import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/data/models/products_model.dart';
import 'package:oson_market/utils/colors/app_colors.dart';


class AboutItem extends StatelessWidget {
  const AboutItem({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              15.r,
            ),
          ),
          color: Theme.of(context).scaffoldBackgroundColor),
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 22.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                Text("Name: ${product.productName}",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 24.sp)),
                SizedBox(height: 10.h),
                Text(
                  "Description:  ${product.productDescription}",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 24.sp),
                ),
                SizedBox(height: 10.h),
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "Price: ",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 24.sp),
                  ),
                  TextSpan(
                    text:
                    "${product.price} ${product.monetaryUnit}",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(
                        fontSize: 24.sp, color: AppColors.c_1317DD),
                  ),
                ])),
                SizedBox(height: 10.h),
                Text(
                  "Vendor: ${product.vendor}",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 24.sp),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Address: ${product.address}",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 24.sp),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Phone number for contact: ${product.phoneNumber}",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 24.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
