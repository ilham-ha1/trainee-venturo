import 'package:get/get.dart';
import 'package:trainee/modules/features/splash/controllers/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}