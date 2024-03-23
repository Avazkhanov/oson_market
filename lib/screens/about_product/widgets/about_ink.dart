import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/utils/colors/app_colors.dart';
import 'package:oson_market/utils/styles/app_style.dart';

class AboutInk extends StatelessWidget {
  const AboutInk({super.key, required this.onTap, required this.text});

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.c_1317DD,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 17.h),
            child: Text(text,
                style: AppStyle.poppinsBold
                    .copyWith(fontSize: 14.sp, color: AppColors.white)),
          ),
        ),
      ),
    );
  }
}
