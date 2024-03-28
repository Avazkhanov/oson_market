import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/screens/globals/global_ink.dart';
import 'package:oson_market/utils/permissions_utils/permissions_utils.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 24.sp,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GlobalInk(
            onTap: () {
              AppPermissions.getCameraPermission();
            },
            text: "Camera permission",
          ),
          SizedBox(height: 10.h),
          GlobalInk(
            onTap: () {
              AppPermissions.getStoragePermission();
            },
            text: "Storage permission",
          ),
          SizedBox(height: 10.h),
          GlobalInk(
            onTap: () {
              AppPermissions.getContactsPermission();
            },
            text: "Contact permission",
          ),
          SizedBox(height: 10.h),
          GlobalInk(
            onTap: () {
              AppPermissions.getLocationPermission();
            },
            text: "Location permission",
          ),
          SizedBox(height: 10.h),
          GlobalInk(
            onTap: () {
              AppPermissions.getSmsPermission();
            },
            text: "Sms permission",
          ),
          SizedBox(height: 10.h),
          GlobalInk(
            onTap: () {
              AppPermissions.getCalendarPermission();
            },
            text: "Calendar permission",
          ),
          SizedBox(height: 10.h),
          GlobalInk(
            onTap: () {
              AppPermissions.getMicrophonePermission();
            },
            text: "Microphone permission",
          ),
          SizedBox(height: 10.h),
          GlobalInk(
            onTap: () {
              AppPermissions.getImportantPermissions();
            },
            text: "Few permission",
          ),
        ],
      ),
    );
  }
}
