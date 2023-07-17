import 'package:get/get.dart';
import 'package:trainee/modules/global_controllers/initial_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(InitialController());
  }
}