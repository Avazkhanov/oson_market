import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oson_market/screens/auth/login/widgets/remember_me_item.dart';
import 'package:oson_market/screens/globals/global_ink.dart';
import 'package:oson_market/screens/globals/global_textfield.dart';
import 'package:oson_market/screens/routes.dart';
import 'package:oson_market/utils/images/app_images.dart';
import 'package:oson_market/utils/styles/app_style.dart';
import 'package:oson_market/utils/validates/app_validates.dart';
import 'package:oson_market/view_models/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors/app_colors.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<AuthViewModel>();
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(AppImages.background, height: 225.h),
                  ),
                  SizedBox(height: 16.32.h),
                  Text("LOGIN",
                      style: AppStyle.poppinsBold.copyWith(fontSize: 22.sp)),
                  GlobalTextField(
                    exp: AppValidates.emailExp,
                    hintText: "Email",
                    controller: emailController,
                    isPassword: false,
                    errorText: "Invalid Email",
                    iconPath: AppImages.emailIcon,
                  ),
                  SizedBox(height: 10.h),
                  GlobalTextField(
                    exp: AppValidates.passwordExp,
                    hintText: "Password",
                    controller: passwordController,
                    isPassword: true,
                    errorText: "Invalid Password",
                    iconPath: AppImages.passwordIcon,
                  ),
                  SizedBox(height: 13.h),
                  const RememberMeItem(),
                  SizedBox(height: 25.h),
                  GlobalInk(
                    onTap: () {
                      provider.login(
                        context,
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    },
                    text: 'Login',
                  ),
                  SizedBox(height: 13.h),
                  Text("OR",
                      style: AppStyle.interRegular.copyWith(fontSize: 16.sp)),
                  SizedBox(height: 13.h),
                  Text("Log in with",
                      style: AppStyle.interRegular.copyWith(fontSize: 16.sp)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      provider.iconList.length,
                      (index) => IconButton(
                        onPressed: () {
                          switch (index) {
                            case 0:
                              provider.signInWithGoogle(context);
                              break;
                            case 2:
                              provider.signInWithFacebook();
                            default:
                              break;
                          }
                        },
                        icon: SvgPicture.asset(provider.iconList[index]),
                      ),
                    ),
                  ),
                  SizedBox(height: 13.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: AppStyle.interRegular.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, RoutesNames.signup);
                        },
                        child: Text(
                          "Register Now",
                          style: AppStyle.poppinsBold.copyWith(
                              color: AppColors.c_1317DD, fontSize: 14.sp),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
