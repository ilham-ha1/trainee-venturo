import 'package:get/get.dart';
import 'package:trainee/modules/features/review/controllers/list_review_controller.dart';

class ListReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListReviewController());
  }
}
