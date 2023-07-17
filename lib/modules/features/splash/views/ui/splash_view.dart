import 'package:flutter/material.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  @override
  Widget build(BuildContext context) {
    analytics.logAppOpen();

    return Scaffold(
      body: Center(
        child: Image.asset(ImageConstant.icJavaCode),
      ),
    );
  }
}
