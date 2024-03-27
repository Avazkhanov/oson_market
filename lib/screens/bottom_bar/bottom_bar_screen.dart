import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oson_market/data/models/push_notification_model.dart';
import 'package:oson_market/screens/routes.dart';
import 'package:oson_market/services/local_notification_service.dart';
import 'package:oson_market/utils/colors/app_colors.dart';
import 'package:oson_market/utils/images/app_images.dart';
import 'package:oson_market/view_models/bottom_view_model.dart';
import 'package:oson_market/view_models/push_notification_view_model.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  String fcmToken = "";

  void _init() async {
    fcmToken = await FirebaseMessaging.instance.getToken() ?? "";
    debugPrint("FCM TOKEN:$fcmToken");
    final token = await FirebaseMessaging.instance.getAPNSToken();
    debugPrint("getAPNSToken : ${token.toString()}");
    LocalNotificationService.localNotificationService;
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage remoteMessage) {
        if (remoteMessage.notification != null) {
          LocalNotificationService().showNotification(
            title: remoteMessage.notification!.title!,
            body: remoteMessage.notification!.body!,
            id: DateTime.now().millisecondsSinceEpoch ~/ 10000,
          );
          context.read<PushNotificationViewModel>().addPushNotification(
                PushNotificationModel(
                  title: remoteMessage.notification!.title!,
                  body: remoteMessage.notification!.body!,
                  id: DateTime.now().millisecondsSinceEpoch ~/ 10000,
                ),
              );

          debugPrint(
              "FOREGROUND NOTIFICATION:${remoteMessage.notification!.title}");
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      context.read<PushNotificationViewModel>().addPushNotification(
            PushNotificationModel(
              title: remoteMessage.notification!.title!,
              body: remoteMessage.notification!.body!,
              id: DateTime.now().millisecondsSinceEpoch ~/ 10000,
            ),
          );
      debugPrint("ON MESSAGE OPENED APP:${remoteMessage.notification!.title}");
    });
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        debugPrint("TERMINATED:${message.notification?.title}");
      }
    });
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<BottomViewModel>();
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        children: [provider.screens[provider.currentIndex]],
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10.w,
        color: Theme.of(context).bottomAppBarTheme.color,
        shape: AutomaticNotchedShape(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(100.r),
              ),
            ),
            const OvalBorder()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 40.w),
            IconButton(
              icon: SvgPicture.asset(
                AppImages.homeIcon,
                height: 25.h,
                colorFilter: ColorFilter.mode(
                    provider.currentIndex == 0
                        ? Theme.of(context).iconTheme.color!
                        : Theme.of(context).cardColor,
                    BlendMode.srcIn),
              ),
              onPressed: () {
                provider.setCurrentIndex(0);
              },
            ),
            const Spacer(),
            IconButton(
              icon: SvgPicture.asset(
                AppImages.profileIcon,
                height: 25.h,
                colorFilter: ColorFilter.mode(
                    provider.currentIndex == 1
                        ? Theme.of(context).iconTheme.color!
                        : Theme.of(context).cardColor,
                    BlendMode.srcIn),
              ),
              onPressed: () {
                provider.setCurrentIndex(1);
              },
            ),
            SizedBox(width: 40.w),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const OvalBorder(),
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.pushNamed(context, RoutesNames.productAdd);
        },
        child: const Icon(
          CupertinoIcons.add,
          color: AppColors.white,
        ),
      ),
    );
  }
}
