import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/data/models/products_model.dart';
import 'package:oson_market/screens/home/widgets/home_grid.dart';
import 'package:oson_market/utils/colors/app_colors.dart';
import 'package:oson_market/utils/styles/app_style.dart';
import 'package:oson_market/view_models/auth_view_model.dart';
import 'package:oson_market/view_models/product_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<AuthViewModel>().getUser;
    var provider = context.watch<ProductsViewModel>();
    return Scaffold(
      body: StreamBuilder<List<ProductModel>>(
          stream: provider.listenProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.hasData) {
              List<ProductModel> list = snapshot.data as List<ProductModel>;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: AppColors.c_162023,
                    pinned: true,
                    expandedHeight: 250.h,
                    title: Text("Welcome ${user?.displayName}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.poppinsBold
                            .copyWith(fontSize: 20.sp, color: AppColors.white)),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            bottom: 10,
                            child: Container(
                              color: AppColors.c_162023,
                              child: Padding(
                                padding: EdgeInsets.only(left: 22.w, top: 80.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Popular",
                                        style: AppStyle.poppinsBold.copyWith(
                                            fontSize: 20.sp,
                                            color: AppColors.white)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 30.h,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.70.w,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      childCount: list.length,
                      (context, index) {
                        var product = list[index];
                        return HomeGrid(product: product);
                      },
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [SizedBox(height: 100.h)],
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
