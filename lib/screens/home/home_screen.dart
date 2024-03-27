import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/data/models/products_model.dart';
import 'package:oson_market/screens/home/widgets/home_grid.dart';
import 'package:oson_market/screens/home/widgets/popular_item.dart';
import 'package:oson_market/services/local_notification_service.dart';
import 'package:oson_market/utils/colors/app_colors.dart';
import 'package:oson_market/utils/styles/app_style.dart';
import 'package:oson_market/view_models/auth_view_model.dart';
import 'package:oson_market/view_models/product_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String fcmToken = "";

  void init() async {
    fcmToken = await FirebaseMessaging.instance.getToken() ?? "";
    debugPrint("FCM TOKEN:$fcmToken");
    final token = await FirebaseMessaging.instance.getAPNSToken();
    debugPrint("getAPNSToken : ${token.toString()}");
    LocalNotificationService.localNotificationService;
    //Foreground
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage remoteMessage) {
        if (remoteMessage.notification != null) {
          LocalNotificationService().showNotification(
            title: remoteMessage.notification!.title!,
            body: remoteMessage.notification!.body!,
            id: DateTime.now().millisecondsSinceEpoch~/10000,
          );

          debugPrint(
              "FOREGROUND NOTIFICATION:${remoteMessage.notification!.title}");
        }
      },
    );
    //Background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      debugPrint("ON MESSAGE OPENED APP:${remoteMessage.notification!.title}");
    });
    // Terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        debugPrint("TERMINATED:${message.notification?.title}");
      }
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<AuthViewModel>().getUser;
    return Scaffold(
      body: StreamBuilder<List<ProductModel>>(
          stream: context.watch<ProductsViewModel>().listenProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.hasData) {
              List<ProductModel> list = snapshot.data as List<ProductModel>;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    actions: [

                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications,
                          size: 24.sp,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(width: 10.w)
                    ],
                    backgroundColor: AppColors.c_162023,
                    pinned: true,
                    expandedHeight: 300.h,
                    title: Text("Welcome ${user?.displayName}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.poppinsBold
                            .copyWith(fontSize: 20.sp, color: AppColors.white)),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        children: [
                          Positioned(
                            top: 70.h,
                            right: 0,
                            left: 0,
                            bottom: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15.w),
                                  child: Text("Popular",
                                      style: AppStyle.poppinsBold.copyWith(
                                          fontSize: 20.sp,
                                          color: AppColors.white)),
                                ),
                                SizedBox(height: 10.h),
                                const PopularItem(),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 30.h,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.70.w,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      childCount: list.length,
                      (context, index) {
                        var product = list[index];
                        return HomeGrid(product: product);
                      },
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [SizedBox(height: 100.h)],
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
