import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/global_models/user_all_review_response.dart';
import 'package:trainee/utils/services/http_service.dart';

class ListReviewController extends GetxController {
  static ListReviewController get to => Get.find<ListReviewController>();

  final RxList<Review> userListReviewlData = <Review>[].obs;
  @override
  void onInit() async {
    super.onInit();
    await getAllUserReview();
  }

  Future<void> getAllUserReview() async {
    try {
      final userAllReviewResponse =
          await HttpService.dioService.getUserAllReview();
      if (userAllReviewResponse != null) {
        userListReviewlData.clear();
        for (var item in userAllReviewResponse.data!) {
          userListReviewlData.add(item);
        }
      }
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
    }
  }
}
