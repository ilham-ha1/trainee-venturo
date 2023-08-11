import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:trainee/modules/features/forgot_password/controllers/otp_controller.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class OtpView extends StatelessWidget {
  const OtpView({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    /// Google analytics untuk tracking user di setiap halaman
    if (Platform.isAndroid) {
      /// Tracking bawah dia masuk screen otp di device android
      analytics.setCurrentScreen(
        screenName: 'OTP Screen',
        screenClassOverride: 'Android',
      );
    } else if (Platform.isIOS) {
      /// Tracking bawah dia masuk screen otp di device ios
      analytics.setCurrentScreen(
        screenName: 'OTP Screen',
        screenClassOverride: 'IOS',
      );
    } else if (Platform.isMacOS) {
      /// Tracking bawah dia masuk screen otp di device macos
      analytics.setCurrentScreen(
        screenName: 'OTP Screen',
        screenClassOverride: 'MacOS',
      );
    }

    if (kIsWeb) {
      /// Tracking bahwa dia masuk screen otp di device web
      analytics.setCurrentScreen(
        screenName: 'OTP Screen',
        screenClassOverride: 'Web',
      );
    }
    return Scaffold(
      backgroundColor: MainColor.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            SizedBox(height: 121.h),
            Image.asset(
              ImageConstant.icJavaCode,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 121.h),
            Obx(
              () => RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleTextStyle.fw600.copyWith(
                    fontSize: 22.sp,
                    color: MainColor.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'Enter OTP sended on your email '.tr,
                    ),
                    TextSpan(
                      text: OtpController.to.email.value,
                      style: GoogleTextStyle.fw400.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue, // Cus
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 40.h),
            // pin input
            Pinput(
              controller: OtpController.to.otpTextController,
              length: 6,
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value != "123456") {
                  return "Invalid OTP".tr;
                }
                return null;
              },
              onCompleted: OtpController.to.onOtpComplete,
            ),
          ],
        ),
      ),
    );
  }
}
