import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';

class ConterController extends GetxController {
  static ConterController get to => Get.find();

  var count = 0.obs;

  void increment() async {
    try {
      GlobalController.to.checkConnection();
      if (GlobalController.to.isConnect.isTrue) {
        count++;
      } else{
        
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }
}
