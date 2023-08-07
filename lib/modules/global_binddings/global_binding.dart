import 'package:get/get.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:trainee/modules/global_controllers/navigation_controller.dart';

class GlobalBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(GlobalController());
    Get.put(NavigationController());
  }
}
