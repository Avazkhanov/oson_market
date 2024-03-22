import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors/app_colors.dart';
import '../../utils/styles/app_style.dart';

class GlobalInk extends StatelessWidget {
  const GlobalInk({super.key, required this.onTap, required this.text});

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
            padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 17.h),
            child: Text(text,
                style: AppStyle.poppinsBold
                    .copyWith(fontSize: 14.sp, color: AppColors.white)),
          ),
        ),
      ),
    );
  }
}
