import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oson_market/data/models/products_model.dart';
import 'package:oson_market/screens/about_product/about_product_screen.dart';
import 'package:oson_market/screens/auth/login/login_screen.dart';
import 'package:oson_market/screens/auth/signup/sign_up_screen.dart';
import 'package:oson_market/screens/home/home_screen.dart';
import 'package:oson_market/screens/notification_screen/notification_screen.dart';
import 'package:oson_market/screens/product_add/product_add_screen.dart';
import 'package:oson_market/screens/profile/my_adds/my_adds_screen.dart';
import 'package:oson_market/screens/profile/permissions/permissions_screen.dart';
import 'package:oson_market/screens/profile/profile_screen/profile_screen.dart';
import 'package:oson_market/screens/profile/update_add/update_adds_screen.dart';

import 'package:oson_market/screens/splash/splash_screen.dart';

import 'bottom_bar/bottom_bar_screen.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.splash:
        return navigate(const SplashScreen());
      case RoutesNames.login:
        return navigate(const LogInScreen());
      case RoutesNames.signup:
        return navigate(const SignUpScreen());
      case RoutesNames.home:
        return navigate(const HomeScreen());
      case RoutesNames.bottomAppBar:
        return navigate(const BottomBar());
      case RoutesNames.profile:
        return navigate(const ProfileScreen());
      case RoutesNames.productAdd:
        return navigate(const ProductAddScreen());
      case RoutesNames.myAdds:
        return navigate(MyAddsScreen(userId: settings.arguments as String));
      case RoutesNames.update:
        return navigate(
            UpdateAddScreen(product: settings.arguments as ProductModel));
      case RoutesNames.aboutProduct:
        return navigate(
            AboutProductScreen(product: settings.arguments as ProductModel));
      case RoutesNames.notification:
        return navigate(const NotificationScreen());
      case RoutesNames.permission:
        return navigate(const PermissionsScreen());
      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text('This page does not exist'),
            ),
          ),
        );
    }
  }

  static navigate(Widget widget) =>
      CupertinoPageRoute(builder: (context) => widget);
}

class RoutesNames {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String bottomAppBar = '/bottom_app_bar';
  static const String productAdd = '/product_add';
  static const String myAdds = '/my_add';
  static const String update = '/update';
  static const String aboutProduct = '/about_product';
  static const String notification = '/notification';
  static const String permission = '/permission';
}
