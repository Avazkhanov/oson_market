import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/data/models/products_model.dart';
import 'package:oson_market/utils/colors/app_colors.dart';
import 'package:oson_market/utils/extension/extension.dart';

class AboutProductScreen extends StatefulWidget {
  const AboutProductScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<AboutProductScreen> createState() => _AboutProductScreenState();
}

class _AboutProductScreenState extends State<AboutProductScreen> {
  String title = "";
  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                elevation: 0,
                expandedHeight: 400.h,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 24.sp,
                    color: top == 56.0 ? AppColors.white : AppColors.black,
                  ),
                ),
                pinned: true,
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    top = constraints.biggest.height;
                    title = top == 56.0 ? widget.product.productName : "";
                    return FlexibleSpaceBar(
                      title: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: 1.0,
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(fontSize: 24.sp),
                        ),
                      ),
                      background: Image.network(
                        width: width,
                        height: 300.h,
                        widget.product.imageUrl,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                ),
              ),
            ];
          },
          body: Container(
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
                      Text("Name: ${widget.product.productName}",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 24.sp)),
                      SizedBox(height: 10.h),
                      Text(
                        "Description:  ${widget.product.productDescription}",
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
                          "${widget.product.price} ${widget.product.monetaryUnit}",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 24.sp, color: AppColors.c_1317DD),
                        ),
                      ])),
                      SizedBox(height: 10.h),
                      Text(
                        "Vendor: ${widget.product.vendor}",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 24.sp),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Address: ${widget.product.address}",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 24.sp),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Phone number for contact: ${widget.product.phoneNumber}",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 24.sp),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
