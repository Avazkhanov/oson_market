import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/screens/globals/global_ink.dart';
import 'package:oson_market/screens/globals/global_textfield.dart';
import 'package:oson_market/utils/images/app_images.dart';
import 'package:oson_market/utils/styles/app_style.dart';
import 'package:oson_market/utils/validates/app_validates.dart';
import 'package:oson_market/view_models/profile_view_model.dart';
import 'package:provider/provider.dart';

changeDialog({required BuildContext context}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      TextEditingController newName = TextEditingController();
      var provider = context.watch<ProfileViewModel>();
      return provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Text("New Name",
                          style:
                              AppStyle.poppinsBold.copyWith(fontSize: 18.sp)),
                      SizedBox(height: 10.h),
                      GlobalTextField(
                          exp: AppValidates.nameRegExp,
                          hintText: "Enter new Name",
                          controller: newName,
                          isPassword: false,
                          errorText: "invalid name",
                          iconPath: AppImages.personIcon),
                      SizedBox(height: 15.h),
                      GlobalInk(
                          onTap: () {
                            provider.updateUsername(newName.text, context);
                          },
                          text: "Submit"),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            );
    },
  );
}
