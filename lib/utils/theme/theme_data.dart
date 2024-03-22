import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/utils/colors/app_colors.dart';
import 'package:oson_market/utils/styles/app_style.dart';

class AppTheme {
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
      cardColor: AppColors.c_162023,
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
        titleLarge: AppStyle.interRegular
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
          color: AppColors.c_979797
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: AppColors.c_EEEEEE,
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: AppColors.c_EEEEEE
      ),
      // colorScheme: const ColorScheme(
      //   brightness: Brightness.light,
      //   primary: Color(0xFF006874),
      //   onPrimary: Color(0xFFFFFFFF),
      //   primaryContainer: Color(0xFF97F0FF),
      //   onPrimaryContainer: Color(0xFF001F24),
      //   secondary: Color(0xFF006874),
      //   onSecondary: Color(0xFFFFFFFF),
      //   secondaryContainer: Color(0xFF97F0FF),
      //   onSecondaryContainer: Color(0xFF001F24),
      //   tertiary: Color(0xFF006874),
      //   onTertiary: Color(0xFFFFFFFF),
      //   tertiaryContainer: Color(0xFF97F0FF),
      //   onTertiaryContainer: Color(0xFF001F24),
      //   error: Color(0xFFBA1A1A),
      //   errorContainer: Color(0xFFFFDAD6),
      //   onError: Color(0xFFFFFFFF),
      //   onErrorContainer: Color(0xFF410002),
      //   background: Color(0xFFF8FDFF),
      //   onBackground: Color(0xFF001F25),
      //   surface: Color(0xFFF8FDFF),
      //   onSurface: Color(0xFF001F25),
      //   surfaceVariant: Color(0xFFDBE4E6),
      //   onSurfaceVariant: Color(0xFF3F484A),
      //   outline: Color(0xFF6F797A),
      //   onInverseSurface: Color(0xFFD6F6FF),
      //   inverseSurface: Color(0xFF00363F),
      //   inversePrimary: Color(0xFF4FD8EB),
      //   shadow: Color(0xFF000000),
      //   surfaceTint: Color(0xFF006874),
      //   outlineVariant: Color(0xFFBFC8CA),
      //   scrim: Color(0xFF000000),
      // ),
      // useMaterial3: true,
      drawerTheme: const DrawerThemeData(backgroundColor: AppColors.white));
  static final darkMode = ThemeData(
    cardTheme: CardTheme(
      color: AppColors.c_363636
    ),
    brightness: Brightness.dark,
    iconTheme: const IconThemeData(color: AppColors.white),
    drawerTheme: const DrawerThemeData(backgroundColor: AppColors.c_363636),
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.black,
      titleTextStyle: AppStyle.interRegular.copyWith(
        fontSize: 20.sp,
        color: AppColors.white,
      ),
      iconTheme: const IconThemeData(color: AppColors.white),
      elevation: 0,
      centerTitle: true,
    ),
    cardColor: AppColors.white,
    textTheme: TextTheme(
      displayLarge: AppStyle.interRegular
          .copyWith(fontSize: 57, color: AppColors.white),
      displayMedium: AppStyle.interRegular
          .copyWith(fontSize: 45, color: AppColors.white),
      displaySmall: AppStyle.interRegular
          .copyWith(fontSize: 36, color: AppColors.white),
      headlineLarge: AppStyle.interRegular
          .copyWith(fontSize: 32, color: AppColors.white),
      headlineMedium: AppStyle.interRegular
          .copyWith(fontSize: 28, color: AppColors.white),
      headlineSmall: AppStyle.interRegular
          .copyWith(fontSize: 24, color: AppColors.white),
      titleLarge: AppStyle.interRegular
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
    bottomAppBarTheme: BottomAppBarTheme(
      color: AppColors.c_363636,
    ),
    // colorScheme: const ColorScheme(
    //   brightness: Brightness.dark,
    //   primary: Color(0xFF4FD8EB),
    //   onPrimary: Color(0xFF00363D),
    //   primaryContainer: Color(0xFF004F58),
    //   onPrimaryContainer: Color(0xFF97F0FF),
    //   secondary: Color(0xFF4FD8EB),
    //   onSecondary: Color(0xFF00363D),
    //   secondaryContainer: Color(0xFF004F58),
    //   onSecondaryContainer: Color(0xFF97F0FF),
    //   tertiary: Color(0xFF4FD8EB),
    //   onTertiary: Color(0xFF00363D),
    //   tertiaryContainer: Color(0xFF004F58),
    //   onTertiaryContainer: Color(0xFF97F0FF),
    //   error: Color(0xFFFFB4AB),
    //   errorContainer: Color(0xFF93000A),
    //   onError: Color(0xFF690005),
    //   onErrorContainer: Color(0xFFFFDAD6),
    //   background: Color(0xFF001F25),
    //   onBackground: Color(0xFFA6EEFF),
    //   surface: Color(0xFF001F25),
    //   onSurface: Color(0xFFA6EEFF),
    //   surfaceVariant: Color(0xFF3F484A),
    //   onSurfaceVariant: Color(0xFFBFC8CA),
    //   outline: Color(0xFF899294),
    //   onInverseSurface: Color(0xFF001F25),
    //   inverseSurface: Color(0xFFA6EEFF),
    //   inversePrimary: Color(0xFF006874),
    //   shadow: Color(0xFF000000),
    //   surfaceTint: Color(0xFF4FD8EB),
    //   outlineVariant: Color(0xFF3F484A),
    //   scrim: Color(0xFF000000),
    // ),
    // useMaterial3: true,
  );
}
