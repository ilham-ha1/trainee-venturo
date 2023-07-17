import 'package:get/get.dart';
import 'package:trainee/modules/features/sign_in/controllers/sign_in_controller.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
  }
}