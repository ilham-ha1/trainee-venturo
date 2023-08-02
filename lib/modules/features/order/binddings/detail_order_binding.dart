import 'package:get/get.dart';
import 'package:trainee/modules/features/order/controllers/detail_order_controller.dart';


class DetailOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailOrderController());
  }
}