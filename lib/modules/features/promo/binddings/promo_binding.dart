import 'package:get/get.dart';
import 'package:trainee/modules/features/promo/controllers/promo_controller.dart';

class PromoBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PromoController());
  }
}
