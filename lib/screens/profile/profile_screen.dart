import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/screens/diologs/alert_dialog.dart';
import 'package:oson_market/screens/diologs/change_password.dart';
import 'package:oson_market/screens/routes.dart';
import 'package:oson_market/view_models/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../../view_models/auth_view_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Future.microtask(() => context.watch<ProfileViewModel>().init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<AuthViewModel>().getUser;
    var provider = context.watch<ProfileViewModel>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        title: Text('Profile', style: Theme.of(context).textTheme.displaySmall),
        actions: [
          IconButton(
            onPressed: () {
              showDeleteAlert(context: context, isLogOut: true,docId: "");
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
                : const Icon(Icons.account_circle),
            title: Text(user?.displayName ?? "",
                style: Theme.of(context).textTheme.titleLarge),
            subtitle: Text("*******${user?.email?.substring(10)}"),
          ),
          ListTile(
            onTap: () {
              changeDialog(context: context);
            },
            title: Text(
              "Change Name",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20.sp),
          ),
          ListTile(
            title: Text("Use dark Mode",
                style: Theme.of(context).textTheme.titleLarge),
            onTap: () {
              provider.setTheme(value: !provider.isDark, context: context);
            },
            trailing: CupertinoSwitch(
              value: provider.isDark,
              onChanged: (v) {
                provider.setTheme(value: v, context: context);
              },
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, RoutesNames.myAdds,arguments: user!.uid);
            },
            title: Text(
              "My adds",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20.sp),
          )
        ],
      ),
    );
  }
}
