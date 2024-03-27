import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/screens/routes.dart';
import 'package:oson_market/utils/extension/extension.dart';
import 'package:oson_market/utils/images/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    User? user = FirebaseAuth.instance.currentUser;
    if (user!= null) {
      FirebaseMessaging.instance.subscribeToTopic("news");
      Navigator.pushReplacementNamed(context, RoutesNames.bottomAppBar);
    } else {
      Navigator.pushReplacementNamed(context, RoutesNames.login);
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.splash),
            SizedBox(height: 25.h),
            Text("OSON Market",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium),
          ],
        ),
      ),
    );
  }
}
