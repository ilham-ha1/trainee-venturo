import 'package:get/get.dart';
import 'package:trainee/modules/features/menu/controllers/menu_controller.dart';
import 'package:trainee/modules/global_controllers/user_order_controller.dart';

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MenuDetailController(), permanent: true);
    Get.put(UserOrderController());
  }
}
