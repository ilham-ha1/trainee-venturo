import 'package:get/get.dart';
import 'package:trainee/modules/features/order/controllers/order_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrderController());
  }
}