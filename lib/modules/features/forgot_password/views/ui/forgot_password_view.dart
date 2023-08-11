import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/forgot_password/controllers/forgot_password_controller.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/shared/customs/text_form_field_custom.dart';
import 'package:trainee/shared/styles/elevated_button_style.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    /// Google analytics untuk tracking user di setiap halaman
    if (Platform.isAndroid) {
      /// Tracking bawah dia masuk screen lupa password di device android
      analytics.setCurrentScreen(
        screenName: 'Forgot Password Screen',
        screenClassOverride: 'Android',
      );
    } else if (Platform.isIOS) {
      /// Tracking bawah dia masuk screen lupa password di device ios
      analytics.setCurrentScreen(
        screenName: 'Forgot Password Screen',
        screenClassOverride: 'IOS',
      );
    } else if (Platform.isMacOS) {
      /// Tracking bawah dia masuk screen lupa password di device macos
      analytics.setCurrentScreen(
        screenName: 'Forgot Password Screen',
        screenClassOverride: 'MacOS',
      );
    }

    if (kIsWeb) {
      /// Tracking bawah dia masuk screen lupa password di device web
      analytics.setCurrentScreen(
        screenName: 'Forgot Password Screen',
        screenClassOverride: 'Web',
      );
    }

    return Scaffold(
      appBar: null,
      extendBody: false,
      backgroundColor: MainColor.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 121.h),
              GestureDetector(
                child: Image.asset(
                  ImageConstant.icJavaCode,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 121.h),
              Text(
                'Add email address to change password'.tr,
                style: GoogleTextStyle.fw600.copyWith(
                  fontSize: 22.sp,
                  color: MainColor.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),
              Form(
                key: ForgotPasswordController.to.formKey,
                child: TextFormFieldCustoms(
                  controller: ForgotPasswordController.to.emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  initialValue: ForgotPasswordController.to.emailValue.value,
                  label: "Email Address".tr,
                  hint: "Input Email Address".tr,
                  isRequired: true,
                  requiredText: "Email address cannot be empty".tr,
                ),
              ),
              SizedBox(height: 40.h),
              ElevatedButton(
                style: EvelatedButtonStyle.mainRounded,
                onPressed: () {
                   ForgotPasswordController.to.sendOtp();
                },
                child: Text(
                  "Change Password".tr,
                  style: GoogleTextStyle.fw800.copyWith(
                    fontSize: 14.sp,
                    color: MainColor.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}