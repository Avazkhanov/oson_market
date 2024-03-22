import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/utils/colors/app_colors.dart';
import 'package:oson_market/utils/styles/app_style.dart';

class WhiteTheme{
  static final whiteMode = ThemeData(
      scaffoldBackgroundColor: AppColors.white,

      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        titleTextStyle: AppStyle.poppinsBold.copyWith(
          fontSize: 22.sp,
          color: AppColors.c_162023,
        ),
        iconTheme: const IconThemeData(color: AppColors.c_162023),
        elevation: 0,
        centerTitle: true,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.c_162023,
      ),
      cardColor: AppColors.white,
      textTheme: TextTheme(
        displayLarge: AppStyle.poppinsBold
            .copyWith(fontSize: 57, color: AppColors.c_162023),
        displayMedium: AppStyle.poppinsBold
            .copyWith(fontSize: 45, color: AppColors.c_162023),
        displaySmall: AppStyle.poppinsBold
            .copyWith(fontSize: 36, color: AppColors.c_162023),
        headlineLarge: AppStyle.interRegular
            .copyWith(fontSize: 32, color: AppColors.c_162023),
        headlineMedium: AppStyle.interRegular
            .copyWith(fontSize: 28, color: AppColors.c_162023),
        headlineSmall: AppStyle.interRegular
            .copyWith(fontSize: 24, color: AppColors.c_162023),
        titleLarge: AppStyle.poppinsBold
            .copyWith(fontSize: 22, color: AppColors.c_162023),
        titleMedium: AppStyle.interRegular
            .copyWith(fontSize: 16, color: AppColors.c_162023),
        titleSmall: AppStyle.interRegular
            .copyWith(fontSize: 14, color: AppColors.c_162023),
        labelLarge: AppStyle.interRegular
            .copyWith(fontSize: 14, color: AppColors.c_162023),
        labelMedium: AppStyle.interRegular
            .copyWith(fontSize: 12, color: AppColors.c_162023),
        labelSmall: AppStyle.interRegular
            .copyWith(fontSize: 11, color: AppColors.c_162023),
        bodyLarge: AppStyle.interRegular
            .copyWith(fontSize: 16, color: AppColors.c_162023),
        bodyMedium: AppStyle.interRegular
            .copyWith(fontSize: 14, color: AppColors.c_162023),
        bodySmall: AppStyle.interRegular
            .copyWith(fontSize: 12, color: AppColors.c_162023),
      ),
      switchTheme: const SwitchThemeData(
        thumbColor: MaterialStatePropertyAll(AppColors.black),
        trackOutlineColor: MaterialStatePropertyAll(AppColors.black),
      ),
      cardTheme: const CardTheme(
          color: AppColors.c_EEEEEE
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: AppColors.c_EEEEEE,
      ),
      timePickerTheme: TimePickerThemeData(
          backgroundColor: AppColors.c_EEEEEE
      ),
      drawerTheme: const DrawerThemeData(backgroundColor: AppColors.white));

}