import 'dart:io';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/configs/routes/main_route.dart';

class GlobalController extends GetxController {
  static GlobalController get to => Get.find();

  /// Check Connection Variable
  var isConnect = false.obs;

  Future<void> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('space.venturo.id');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnect.value = true;
      }
    } on SocketException catch (exception, stackTrace) {
      isConnect.value = false;
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );

      Get.offAllNamed(MainRoute.noConnection);
    }
  }

  Future<void> checkConnectionInPageUsingButton() async {
    try {
      final result = await InternetAddress.lookup('space.venturo.id');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnect.value = true;
      }
    } on SocketException catch (exception, stackTrace) {
      isConnect.value = false;
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }
}
