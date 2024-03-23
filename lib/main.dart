import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/options/firebase_options.dart';
import 'package:oson_market/screens/routes.dart';
import 'package:oson_market/utils/theme/theme_data.dart';
import 'package:oson_market/view_models/auth_view_model.dart';
import 'package:oson_market/view_models/bottom_view_model.dart';
import 'package:oson_market/view_models/my_adds_view_model.dart';
import 'package:oson_market/view_models/product_view_model.dart';
import 'package:oson_market/view_models/profile_view_model.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  User? user = FirebaseAuth.instance.currentUser;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => BottomViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => MyAddsViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        ScreenUtil.init(context);
        return AdaptiveTheme(
          light: AppTheme.whiteMode,
          dark: AppTheme.darkMode,
          initial: AdaptiveThemeMode.light,
          builder: (theme, darkTheme) {
            return MaterialApp(
              theme: theme,
              darkTheme: darkTheme,
              debugShowCheckedModeBanner: false,
              initialRoute: RoutesNames.splash,
              onGenerateRoute: AppRoutes.generateRoute,
            );
          },
        );
      },
    );
  }
}
