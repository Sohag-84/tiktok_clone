// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/screens/auth/signup_screen.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "TikTok",
            style: TextStyle(
              color: buttonColor,
              fontSize: 35.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            "Login",
            style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 20.h),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextInputField(
              controller: _emailController,
              icon: Icons.email,
              labelText: 'Email',
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextInputField(
              controller: _passwordController,
              icon: Icons.lock,
              labelText: 'Password',
            ),
          ),
          SizedBox(height: 30.h),
          InkWell(
            onTap: () => authController.userLogin(
                _emailController.text, _passwordController.text),
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: buttonColor,
              ),
              child: Center(
                child: Text(
                  "Log in",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account?',
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
              TextButton(
                onPressed: () => Get.to(() => SignupScreen()),
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 15.h,
                    color: buttonColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
