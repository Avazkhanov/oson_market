import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/styles/app_style.dart';

class GlobalTextField extends StatefulWidget {
  const GlobalTextField(
      {super.key,
      required this.exp,
      required this.hintText,
      required this.controller,
      required this.isPassword,
      required this.errorText,
      required this.iconPath});

  final RegExp exp;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final String errorText;
  final String iconPath;

  @override
  State<GlobalTextField> createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {
  var eye = CupertinoIcons.eye;
  bool obscureText = false;

  @override
  void initState() {
    if (widget.isPassword) {
      obscureText = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            boxShadow: const [
              BoxShadow(
                color: AppColors.grey,
                spreadRadius: 0,
                blurRadius: 12,
                offset: Offset(0, 14),
              ),
            ],
          ),
        ),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? obscureText : false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (String? value) {
            if (value != null && widget.exp.hasMatch(value)) {
              return null;
            } else {
              return widget.errorText;
            }
          },
          style: AppStyle.interRegular.copyWith(fontSize: 22.sp),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 13.h),
            fillColor: AppColors.white,
            filled: true,
            hintText: widget.hintText,
            hintStyle: AppStyle.interRegular.copyWith(fontSize: 22.sp),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                  widget.iconPath
              ),
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
              onPressed: () {
                if (obscureText) {
                  obscureText = false;
                  eye = CupertinoIcons.eye_slash;
                } else {
                  obscureText = true;
                  eye = CupertinoIcons.eye;
                }
                setState(() {});
              },
              icon: Icon(eye),
            )
                : null,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.red,width: 1.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.white,width: 1.w),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.white,width: 1.w),
            ),
          ),
        ),
      ],
    );
  }
}
