import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/data/models/notification_model.dart';
import 'package:oson_market/data/models/products_model.dart';
import 'package:oson_market/screens/globals/product_textfield.dart';
import 'package:oson_market/screens/globals/global_ink.dart';
import 'package:oson_market/services/local_notification_service.dart';
import 'package:oson_market/utils/utility_function.dart';
import 'package:oson_market/view_models/auth_view_model.dart';
import 'package:oson_market/view_models/notification_view_model.dart';
import 'package:oson_market/view_models/product_view_model.dart';
import 'package:provider/provider.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<ProductsViewModel>();
    var userID = context.watch<AuthViewModel>().getUser;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 24.sp),
        ),
      ),
      body: provider.getLoader
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    ProductTextField(
                        hintText: "Product Name",
                        controller: _nameController,
                        action: TextInputAction.next),
                    SizedBox(height: 15.h),
                    ProductTextField(
                      hintText: "Product Price",
                      controller: _priceController,
                      action: TextInputAction.next,
                    ),
                    SizedBox(height: 15.h),
                    ProductTextField(
                      hintText: "Description",
                      controller: _descriptionController,
                      action: TextInputAction.next,
                    ),
                    SizedBox(height: 15.h),
                    ProductTextField(
                      hintText: "Image",
                      controller: _imageController,
                      action: TextInputAction.next,
                    ),
                    SizedBox(height: 15.h),
                    ProductTextField(
                      hintText: "Category",
                      controller: _categoryController,
                      action: TextInputAction.next,
                    ),
                    SizedBox(height: 15.h),
                    ProductTextField(
                      hintText: "Enter your address",
                      controller: _addressController,
                      action: TextInputAction.next,
                    ),
                    SizedBox(height: 15.h),
                    ProductTextField(
                      hintText: "Enter your phone number",
                      controller: _phoneController,
                      action: TextInputAction.done,
                    ),
                    SizedBox(height: 15.h),
                    DropdownButtonFormField<String>(
                      hint: Text(
                        'Select Monetary Unit',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 18.sp),
                      ),
                      value: provider.dropdownValue,
                      onChanged: (String? value) => provider.changeValue(value),
                      items: <String>['\$', "So'm", '₱']
                          .map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: 18.sp),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                    SizedBox(height: 15.h),
                    GlobalInk(
                        onTap: () {
                          ProductModel productModel = ProductModel(
                              price: double.parse(_priceController.text),
                              imageUrl:
                                  "https://toppng.com/uploads/preview/apple-iphone-15-pro-max-lineup-colorful-titanium-png-11695041236xwlfeshu9j.png",
                              productName: _nameController.text,
                              docId: "",
                              productDescription: _descriptionController.text,
                              categoryId: "af",
                              userId: userID!.uid,
                              monetaryUnit: provider.dropdownValue!,
                              countViews: 0,
                              address: _addressController.text,
                              phoneNumber: _phoneController.text,
                              vendor: userID.displayName!);
                          if (productModel.canInsertProduct()) {
                            provider.insertProducts(productModel, context);

                          } else {
                            showSneckbar(
                                context: context,
                                message: "fill in all fields");
                          }
                        },
                        text: "Save")
                  ],
                ),
              ),
            ),
    );
  }
}
