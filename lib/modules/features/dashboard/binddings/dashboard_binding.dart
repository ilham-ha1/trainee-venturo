import 'package:get/get.dart';
import 'package:trainee/modules/features/list/controllers/list_controller.dart';
import 'package:trainee/modules/features/order/controllers/order_controller.dart';
import 'package:trainee/modules/features/profile/controllers/profile_controller.dart';
import 'package:trainee/modules/global_controllers/navigation_controller.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(NavigationController());
    //pages
    Get.put(ListController());
    Get.put(OrderController());
    Get.put(ProfileController());
  }
}
