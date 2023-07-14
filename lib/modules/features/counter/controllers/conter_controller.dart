import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ConterController extends GetxController {
  static ConterController get to => Get.find();

  var count = 0.obs;

 void increment() async {
    try {
      count++;
      throw Exception('Error occurred');
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

}
