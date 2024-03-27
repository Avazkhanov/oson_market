import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:oson_market/utils/images/app_images.dart';
import 'package:oson_market/view_models/push_notification_view_model.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var notifications = context.watch<PushNotificationViewModel>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 24.sp,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              notifications.clearPushNotifications();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.done_all,
              size: 24.sp,
            ),
          ),
        ],
      ),
      body: notifications.pushNotifications.isNotEmpty
          ? ListView.builder(
              itemCount: notifications.pushNotifications.length,
              itemBuilder: (context, index) {
                var notification = notifications.pushNotifications[index];
                return ListTile(
                  title: Text(notification.title),
                  subtitle: Text(notification.body),
                );
              },
            )
          : Center(
              child: LottieBuilder.asset(AppImages.empty),
            ),
    );
  }
}
