import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/utils/colors/app_colors.dart';
import 'package:oson_market/utils/styles/app_style.dart';
import 'package:oson_market/view_models/auth_view_model.dart';
import 'package:provider/provider.dart';


class RememberMeItem extends StatelessWidget {
  const RememberMeItem({super.key});


  @override
  Widget build(BuildContext context) {
    var provider = context.watch<AuthViewModel>();
    return Row(
      children: [
        SizedBox(width: 10.w),
        Switch(
          activeTrackColor: AppColors.c_1317DD,
          value: provider.isSwitching,
          onChanged: (value) => provider.switchOnChange(value),
        ),
        SizedBox(width: 6.w),
        GestureDetector(
          onTap: (){},
          child: Text("Remember me",
              style: AppStyle.interRegular.copyWith(fontSize: 12.sp)),
        ),
        const Spacer(),
        Text("Forgot Password?",
            style: AppStyle.interRegular.copyWith(fontSize: 12.sp)),
        SizedBox(width: 10.w),
      ],
    );
  }
}
