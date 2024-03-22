import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/screens/diologs/change_password.dart';
import 'package:oson_market/utils/styles/app_style.dart';
import 'package:provider/provider.dart';

import '../../view_models/auth_view_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = context.watch<AuthViewModel>().getUser;
    var provider = context.watch<AuthViewModel>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        title: Text('Profile', style: Theme.of(context).textTheme.displaySmall),
        actions: [
          IconButton(
            onPressed: () {
              provider.logout(context);
            },
            icon: Icon(Icons.logout, size: 30.sp),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            leading: user?.photoURL != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child: Image.network(user!.photoURL!),
                  )
                : Icon(Icons.person),
            title: Text(user?.displayName ?? "",
                style: AppStyle.poppinsBold.copyWith(fontSize: 18.sp)),
            subtitle: Text("*******${user?.email?.substring(10)}"),
          ),
          ListTile(
            onTap: () {
              changeDialog(context: context);
            },
            title: Text(
              "Change Name",
              style: AppStyle.poppinsBold.copyWith(fontSize: 18.sp),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20.sp),
          )
        ],
      ),
    );
  }
}
