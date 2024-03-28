import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/screens/routes.dart';
import 'package:oson_market/services/firebase_options.dart';
import 'package:oson_market/services/local_notification_service.dart';
import 'package:oson_market/utils/theme/theme_data.dart';
import 'package:oson_market/view_models/auth_view_model.dart';
import 'package:oson_market/view_models/bottom_view_model.dart';
import 'package:oson_market/view_models/image_view_model.dart';
import 'package:oson_market/view_models/my_adds_view_model.dart';
import 'package:oson_market/view_models/notification_view_model.dart';
import 'package:oson_market/view_models/product_view_model.dart';
import 'package:oson_market/view_models/profile_view_model.dart';
import 'package:oson_market/view_models/push_notification_view_model.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint(
      "BACKGROUND MODE DA PUSH NOTIFICATION KELDI:${message.notification!.title}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureLocalTimeZone();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.instance.subscribeToTopic("news");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
        ChangeNotifierProvider(
          create: (_) => NotificationViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => PushNotificationViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ImageViewModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    LocalNotificationService.localNotificationService.init(navigatorKey);
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
              navigatorKey: navigatorKey,
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
