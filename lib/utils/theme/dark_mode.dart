import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/utils/colors/app_colors.dart';
import 'package:oson_market/utils/styles/app_style.dart';

class DarkTheme{
  static final darkMode = ThemeData(
    cardTheme: CardTheme(
        color: AppColors.c_363636
    ),
    brightness: Brightness.light,
    iconTheme: const IconThemeData(color: AppColors.white),
    drawerTheme: const DrawerThemeData(backgroundColor: AppColors.c_363636),
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.black,
      titleTextStyle: AppStyle.poppinsBold.copyWith(
        fontSize: 20.sp,
        color: AppColors.white,
      ),
      iconTheme: const IconThemeData(color: AppColors.white),
      elevation: 0,
      centerTitle: true,
    ),
    sliderTheme: SliderThemeData(

    ),
    cardColor: AppColors.white,
    textTheme: TextTheme(
      displayLarge: AppStyle.poppinsBold
          .copyWith(fontSize: 57, color: AppColors.white),
      displayMedium: AppStyle.poppinsBold
          .copyWith(fontSize: 45, color: AppColors.white),
      displaySmall: AppStyle.poppinsBold
          .copyWith(fontSize: 36, color: AppColors.white),
      headlineLarge: AppStyle.interRegular
          .copyWith(fontSize: 32, color: AppColors.white),
      headlineMedium: AppStyle.interRegular
          .copyWith(fontSize: 28, color: AppColors.white),
      headlineSmall: AppStyle.interRegular
          .copyWith(fontSize: 24, color: AppColors.white),
      titleLarge: AppStyle.poppinsBold
          .copyWith(fontSize: 22, color: AppColors.white),
      titleMedium: AppStyle.interRegular
          .copyWith(fontSize: 16, color: AppColors.white),
      titleSmall: AppStyle.interRegular
          .copyWith(fontSize: 14, color: AppColors.white),
      labelLarge:
      AppStyle.interRegular.copyWith(fontSize: 14, color: AppColors.white),
      labelMedium:
      AppStyle.interRegular.copyWith(fontSize: 12, color: AppColors.white),
      labelSmall:
      AppStyle.interRegular.copyWith(fontSize: 11, color: AppColors.white),
      bodyLarge:
      AppStyle.interRegular.copyWith(fontSize: 16, color: AppColors.white),
      bodyMedium:
      AppStyle.interRegular.copyWith(fontSize: 14, color: AppColors.white),
      bodySmall:
      AppStyle.interRegular.copyWith(fontSize: 12, color: AppColors.white),
    ),
    switchTheme: const SwitchThemeData(
      thumbColor: MaterialStatePropertyAll(AppColors.white),
      trackOutlineColor: MaterialStatePropertyAll(AppColors.black),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: AppColors.c_363636,
    ),
  );

}