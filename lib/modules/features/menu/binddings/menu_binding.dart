import 'package:get/get.dart';
import 'package:trainee/modules/features/menu/controllers/menu_controller.dart';

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MenuDetailController());
  }
}
