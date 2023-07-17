import 'dart:async';

import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/utils/services/local_storage_service.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find();

  @override
  void onReady() {
    super.onReady();
    loading();
  }

  Future<void> loading() async{
    Timer(
      const Duration(seconds: 1),
      () {
        if (LocalStorageService.isLoggedIn() == true) {
          Get.offNamed(MainRoute.getLocation); // Navigate to the Initial page
        } else {
          Get.offNamed(MainRoute.signIn); // Navigate to the SignIn page
        }
      },
    );
  }
}
