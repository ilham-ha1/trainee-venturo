import 'package:get/get.dart';
import 'package:trainee/modules/features/edit_menu/controllers/edit_menu_controller.dart';

class EditMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditMenuController());
  }
}