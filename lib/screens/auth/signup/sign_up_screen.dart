import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oson_market/screens/globals/global_ink.dart';
import 'package:oson_market/screens/globals/global_textfield.dart';
import 'package:oson_market/screens/routes.dart';
import 'package:oson_market/utils/images/app_images.dart';
import 'package:oson_market/utils/styles/app_style.dart';
import 'package:oson_market/utils/validates/app_validates.dart';
import 'package:oson_market/view_models/auth_view_model.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<AuthViewModel>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  Image.asset(AppImages.signup, height: 186.h),
                  SizedBox(height: 30.h),
                  Text("Sign Up",
                      style: AppStyle.poppinsBold.copyWith(fontSize: 22.sp)),
                  SizedBox(height: 16.h),
                  GlobalTextField(
                    exp: AppValidates.nameRegExp,
                    hintText: "Enter FullName",
                    controller: nameController,
                    isPassword: false,
                    errorText: "Invalid Name",
                    iconPath: AppImages.personIcon,
                  ),
                  SizedBox(height: 10.h),
                  GlobalTextField(
                    exp: AppValidates.emailExp,
                    hintText: "Enter Email",
                    controller: emailController,
                    isPassword: false,
                    errorText: "Invalid Email",
                    iconPath: AppImages.emailIcon,
                  ),
                  SizedBox(height: 10.h),
                  GlobalTextField(
                    exp: AppValidates.passwordExp,
                    hintText: "Enter Password",
                    controller: passwordController,
                    isPassword: true,
                    errorText: "Invalid Password",
                    iconPath: AppImages.passwordIcon,
                  ),
                  SizedBox(height: 32.h),
                  GlobalInk(
                    onTap: () {
                      provider.registerUser(
                        context,
                        email: emailController.text,
                        password: passwordController.text,
                        username: nameController.text,
                      );
                    },
                    text: 'Sign Up',
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account",
                          style:
                              AppStyle.interRegular.copyWith(fontSize: 14.sp)),
                      SizedBox(width: 10.w),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, RoutesNames.login);
                        },
                        child: Text(
                          "Login",
                          style: AppStyle.poppinsBold.copyWith(
                              fontSize: 14.sp, color: Colors.blue),
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
