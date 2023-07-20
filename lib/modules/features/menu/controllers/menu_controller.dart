import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/global_models/detail_menu_response.dart';
import 'package:trainee/utils/services/http_service.dart';

class MenuDetailController extends GetxController {
  static MenuDetailController get to => Get.find();

  int itemIdMenu = 0;

  @override
  void onInit() {
    super.onInit();
    itemIdMenu = Get.arguments;
  }

  final Rx<DataDetailMenu> detailMenu = DataDetailMenu().obs;
  Future observePromos() async {
    try {
      final detailMenuResponse =
          await HttpService.dioService.getDetailMenu(itemIdMenu.toString());
      if (detailMenuResponse?.menu != null) {
        detailMenu.value = DataDetailMenu(
          menu: detailMenuResponse!.menu,
          topping: detailMenuResponse.topping,
          level: detailMenuResponse.level,
        );
      }
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
    }
  }
}
