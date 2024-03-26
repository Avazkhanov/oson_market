import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/screens/globals/global_ink.dart';
import 'package:oson_market/utils/colors/app_colors.dart';
import 'package:oson_market/utils/styles/app_style.dart';
import 'package:oson_market/view_models/my_adds_view_model.dart';
import 'package:oson_market/view_models/profile_view_model.dart';
import 'package:provider/provider.dart';

showDeleteAlert({
  required BuildContext context,
  required bool isLogOut,
  required String docId,
  required String useId
}) {
  showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: AppColors.transparent,
          child: StatefulBuilder(builder: (context, setState) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              margin: EdgeInsets.symmetric(vertical: 220.h, horizontal: 20.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(16.r),
                  color: Theme.of(context).bottomAppBarTheme.color),
              child: Column(
                children: [
                  SizedBox(height: 2.h),
                  Text(
                    isLogOut? "Log out" : "Delete Add",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.w, color: AppColors.c_979797),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    isLogOut? "Are you sure want to log out?": "Are you sure you want to delete this ad?",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Material(
                    color: AppColors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Ink(
                          decoration: BoxDecoration(
                            color: AppColors.c_1317DD,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            borderRadius: BorderRadius.circular(30.r),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 17.h),
                              child: Text("Cancel",
                                  style: AppStyle.poppinsBold
                                      .copyWith(fontSize: 14.sp, color: AppColors.white)),
                            ),
                          ),
                        ),
                        Ink(
                          decoration: BoxDecoration(
                            color: AppColors.c_1317DD,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: InkWell(
                            onTap: (){
                              if(isLogOut){
                                context.read<ProfileViewModel>().logout(context);
                              }else{
                                context.read<MyAddsViewModel>().deleteProduct(docId, context,useId);
                              }
                              Navigator.of(context).pop();
                            },
                            borderRadius: BorderRadius.circular(30.r),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 17.h),
                              child: Text(isLogOut? "Log Out" : "Delete",
                                  style: AppStyle.poppinsBold
                                      .copyWith(fontSize: 14.sp, color: AppColors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                ],
              ),
            );
          }),
        );
      });
}