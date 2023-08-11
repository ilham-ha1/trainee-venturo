import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/sign_in/controllers/sign_in_controller.dart';
import 'package:trainee/modules/features/sign_in/views/components/form_sign_in_component.dart';
import 'package:trainee/shared/styles/google_text_style.dart';
import 'package:trainee/shared/styles/elevated_button_style.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    /// Google analytics untuk tracking user di setiap halaman
    if (Platform.isAndroid) {
      /// Tracking bawah dia masuk screen sign in di device android
      analytics.setCurrentScreen(
        screenName: 'Sign In Screen',
        screenClassOverride: 'Android',
      );
    } else if (Platform.isIOS) {
      /// Tracking bawah dia masuk screen sign in di device ios
      analytics.setCurrentScreen(
        screenName: 'Sign In Screen',
        screenClassOverride: 'IOS',
      );
    } else if (Platform.isMacOS) {
      /// Tracking bawah dia masuk screen sign in di device macos
      analytics.setCurrentScreen(
        screenName: 'Sign In Screen',
        screenClassOverride: 'MacOS',
      );
    }

    if (kIsWeb) {
      /// Tracking bawah dia masuk screen sign in di device web
      analytics.setCurrentScreen(
        screenName: 'Sign In Screen',
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
                onDoubleTap: () => SignInController.to.flavorSeting(),
                child: Image.asset(
                  ImageConstant.icJavaCode,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 121.h),
              Text(
                'Login to continue!'.tr,
                style: GoogleTextStyle.fw600.copyWith(
                  fontSize: 22.sp,
                  color: MainColor.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),
              const FormSignInCompoent(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.toNamed(MainRoute.forgotPassword);
                  },
                  child: Text(
                    "Forget Password?".tr,
                    style: GoogleTextStyle.fw600.copyWith(
                      fontSize: 14.sp,
                      color: MainColor.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              ElevatedButton(
                style: EvelatedButtonStyle.mainRounded,
                onPressed: () => SignInController.to.validateForm(context),
                child: Text(
                  "Login".tr,
                  style: GoogleTextStyle.fw800.copyWith(
                    fontSize: 14.sp,
                    color: MainColor.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: Color.fromARGB(145, 51, 51, 51),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      'or'.tr,
                      style: GoogleTextStyle.fw400.copyWith(
                        color: const Color.fromARGB(145, 51, 51, 51),
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: Color.fromARGB(145, 51, 51, 51),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: EvelatedButtonStyle.googleRounded,
                onPressed: () => SignInController.to.signInWithGoogle(),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset(ImageConstant.icGoogle),
                        ),
                        const SizedBox(width: 30),
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              TextSpan(text: 'Login Using '.tr, style: GoogleTextStyle.fw400.copyWith(),),
                               TextSpan(
                                text: 'Google',
                                style: GoogleTextStyle.fw800.copyWith(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                style: EvelatedButtonStyle.mainRounded.copyWith(
                  backgroundColor: const MaterialStatePropertyAll(Colors.black),
                ),
                onPressed: () => () {},
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset(ImageConstant.icApple),
                        ),
                        const SizedBox(width: 30),
                        RichText(
                          text: TextSpan(
                            style:  GoogleTextStyle.fw400.copyWith(
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(text: 'Login Using '.tr,style: GoogleTextStyle.fw400.copyWith(),),
                              TextSpan(
                                text: 'Apple',
                                style: GoogleTextStyle.fw800.copyWith(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
