import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/data/models/products_model.dart';
import 'package:oson_market/view_models/product_view_model.dart';
import 'package:provider/provider.dart';

class PopularItem extends StatelessWidget {
  const PopularItem({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.watch<ProductsViewModel>().getPopularProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductModel> popularProducts =
                snapshot.data as List<ProductModel>;
            return CarouselSlider(
              items: List.generate(
                popularProducts.length,
                (index) {
                  var popularProduct = popularProducts[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 15.h),
                    height: 150.h,
                    width: 240.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: Theme.of(context).cardColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15.r)),
                          child: Image.network(
                            popularProduct.imageUrl,
                            height: 130.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            popularProduct.productName,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontSize: 18.sp,
                                ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              options: CarouselOptions(
                // height: 150,
                viewportFraction: 0.68.w,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.linear,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
