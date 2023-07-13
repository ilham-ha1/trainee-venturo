import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/pages/main_page.dart';
import 'dart:async';

import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/modules/features/counter/views/ui/conter_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () => Get.offNamed(MainRoute.initial), // Navigate to the ConterView
    );
    return Scaffold(
      body: Center(
        child: Image.asset(ImageConstant.icJavaCode),
      ),
    );
  }
}