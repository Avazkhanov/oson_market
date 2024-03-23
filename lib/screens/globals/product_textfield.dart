import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductTextField extends StatelessWidget {
  const ProductTextField({super.key, required this.hintText, required this.controller, required this.action});
  final String hintText;
  final TextEditingController controller;
  final TextInputAction action;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: action,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 18.sp),
      maxLines: 3,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 18.sp),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
    );
  }
}
