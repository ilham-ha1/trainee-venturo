import 'package:get/get.dart';
import 'package:trainee/modules/features/list/controllers/list_controller.dart';
import 'package:trainee/modules/global_controllers/user_order_controller.dart';

class ListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListController(), permanent: true);
    Get.put(UserOrderController());
  }
}
