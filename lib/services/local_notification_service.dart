import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:oson_market/data/models/products_model.dart';
import 'package:oson_market/screens/about_product/about_product_screen.dart';
import 'package:oson_market/screens/routes.dart';
import "package:timezone/data/latest_all.dart" as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}
class LocalNotificationService {
  static final LocalNotificationService localNotificationService =
  LocalNotificationService._();

  factory LocalNotificationService() {
    return localNotificationService;
  }

  LocalNotificationService._();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void init(GlobalKey<NavigatorState> navigatorKey) async {
    // Android
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings("oson");

    //IOS
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    InitializationSettings initializationSettings = InitializationSettings(
        iOS: initializationSettingsDarwin,
        android: androidInitializationSettings);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (notification) {
          if (notification.payload != null) {
            var payloadMap = jsonDecode(notification.payload!);
            debugPrint("CURRENT NOTIFICATION PRODUCT: ${payloadMap}");
            ProductModel productModel = ProductModel.fromJson(payloadMap);
            print("CURRENT CONTEXT:${navigatorKey.currentContext}");
            Navigator.push(navigatorKey.currentContext!, CupertinoPageRoute(builder: (context)=> AboutProductScreen(product: productModel)));
          }
        });

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    tz.initializeTimeZones();
  }

  @pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
    print("TAPPED FROM BACKGROUND");
  }

  AndroidNotificationChannel androidNotificationChannel =
  const AndroidNotificationChannel(
    "my_channel",
    "Notification Lesson ",
    importance: Importance.max,
    description: "My Notification description",
  );

  //IOS
  void onDidReceiveLocalNotification(
      int id,
      String? title,
      String? body,
      String? payload,
      ) async {
  }

  void showNotification({
    required String title,
    required String body,
    required int id,
    ProductModel? productModel,
  }) {
    flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          priority: Priority.max,
          playSound: true,
          icon: "oson",
          showProgress: true,
          largeIcon: const DrawableResourceAndroidBitmap('oson'),
        ),
        iOS: DarwinNotificationDetails(
          subtitle: title,
          presentAlert: true,
          presentSound: true,
          interruptionLevel: InterruptionLevel.active,
        ),
      ),
      payload: productModel!= null? jsonEncode(productModel.toJson()):null,
    );
    debugPrint("CURRENT NOTIFICATION PRODUCT: ${productModel?.productName}");
    debugPrint("CURRENT NOTIFICATION ID:$id");
  }


  void scheduleNotification({
    required String title,
    required String body,
    required int delayedTime,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        123,
        'scheduled alarm clock title',
        'scheduled alarm clock body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'alarm_clock_channel', 'Alarm Clock Channel',
                channelDescription: 'Alarm Clock Notification')),
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

  void showPeriodicNotification({
    required String title,
    required String body,
  }) {
    flutterLocalNotificationsPlugin.periodicallyShow(
      2,
      title,
      body,
      RepeatInterval.everyMinute,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          priority: Priority.max,
          playSound: true,
          icon: "oson",
          showProgress: true,
          largeIcon: const DrawableResourceAndroidBitmap('oson'),
        ),
      ),
    );
  }

  cancelNotification(int id) {
    flutterLocalNotificationsPlugin.cancel(id);
  }

  cancelAll() {
    flutterLocalNotificationsPlugin.cancelAll();
  }
}