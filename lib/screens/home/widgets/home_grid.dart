import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/data/models/products_model.dart';
import 'package:oson_market/screens/routes.dart';
import 'package:oson_market/utils/extension/extension.dart';
import 'package:oson_market/view_models/product_view_model.dart';
import 'package:provider/provider.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(15.r)),
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: Material(
          child: InkWell(
            onTap: () {
              int count = product.countViews + 1;
              var temp = product.copyWith(countViews: count);
              context.read<ProductsViewModel>().updateProduct(temp, context,false);
              print(product.countViews);
              Navigator.pushNamed(context, RoutesNames.aboutProduct,
                  arguments: product);
            },
            borderRadius: BorderRadius.circular(15.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.network(product.imageUrl,
                      width: width, height: 105.h, fit: BoxFit.cover),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 14.sp),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Price:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 14.sp),
                            ),
                            TextSpan(
                              text:
                                  " ${product.monetaryUnit} ${product.price.toString()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: 14.sp,
                                    color: Colors.blue,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite_border,
                              size: 24.sp,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
