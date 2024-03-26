import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/data/models/products_model.dart';
import 'package:oson_market/screens/globals/global_ink.dart';
import 'package:oson_market/screens/globals/product_textfield.dart';
import 'package:oson_market/view_models/product_view_model.dart';
import 'package:provider/provider.dart';


class UpdateAddScreen extends StatefulWidget {
  const UpdateAddScreen({super.key, required this.product});
  final ProductModel product;

  @override
  State<UpdateAddScreen> createState() => _UpdateAddScreenState();
}

class _UpdateAddScreenState extends State<UpdateAddScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.product.productName;
    _priceController.text = widget.product.price.toString();
    _descriptionController.text = widget.product.productDescription;
    _categoryController.text = widget.product.categoryId;
    _imageController.text = widget.product.imageUrl;
    _addressController.text = widget.product.address;
    _phoneController.text = widget.product.phoneNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<ProductsViewModel>();
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
                  hintText: "Product Name", controller: _nameController, action: TextInputAction.next,),
              SizedBox(height: 15.h),
              ProductTextField(
                  hintText: "Product Price",
                  controller: _priceController, action: TextInputAction.next,),
              SizedBox(height: 15.h),
              ProductTextField(
                  hintText: "Description",
                  controller: _descriptionController, action: TextInputAction.next,),
              SizedBox(height: 15.h),
              ProductTextField(
                  hintText: "Image", controller: _imageController, action: TextInputAction.next,),
              SizedBox(height: 15.h),
              ProductTextField(
                  hintText: "Category", controller: _categoryController, action: TextInputAction.next,),
              SizedBox(height: 15.h),
              ProductTextField(
                hintText: "Category", controller: _addressController, action: TextInputAction.next,),
              SizedBox(height: 15.h),
              ProductTextField(
                hintText: "Category", controller: _phoneController, action: TextInputAction.next,),
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
                    var temp = widget.product.copyWith(
                      productName: _nameController.text,
                      price: double.parse(_priceController.text),
                      productDescription: _descriptionController.text,
                      categoryId: _categoryController.text,
                      monetaryUnit: provider.dropdownValue
                    );
                    provider.updateProduct(temp, context,true);
                  },
                  text: "Save")
            ],
          ),
        ),
      ),
    );
  }
}
