import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/data/models/products_model.dart';
import 'package:oson_market/screens/about_product/widgets/about_ink.dart';
import 'package:oson_market/screens/about_product/widgets/about_item.dart';
import 'package:oson_market/screens/globals/global_ink.dart';
import 'package:oson_market/utils/colors/app_colors.dart';
import 'package:oson_market/utils/extension/extension.dart';
import 'package:url_launcher/url_launcher.dart';

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
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border, size: 24.sp),
                  ),
                ],
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
          body: AboutItem(product: widget.product),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          SizedBox(
            height: 50.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AboutInk(
                  onTap: () async {
                    String uri =
                        'sms:${widget.product.phoneNumber}?body=${Uri.encodeComponent("Assalomu alaykum ${widget.product.vendor} men oson marketga joylashtirgan mahsulotingiz bo'yicha yozayotgan edim menga bog'lana olasizmi ?")}';
                    await launchUrl(Uri.parse(uri));
                  },
                  text: "Contact by SMS",
                ),
                AboutInk(
                  onTap: () async {
                    Uri uri = Uri(
                      scheme: 'tel',
                      path: widget.product.phoneNumber,
                    );
                    await launchUrl(uri);
                  },
                  text: "Contact by Phone",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
