import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/global_models/detail_menu_response.dart';
import 'package:trainee/utils/services/http_service.dart';

class MenuDetailController extends GetxController {
  static MenuDetailController get to => Get.find();

  final RxInt itemIdMenu = 0.obs;

  @override
  void onInit() async{
    super.onInit();
    itemIdMenu.value = Get.arguments;
    await observeMenu();
  }

  final Rx<Menu> menu = Menu().obs;
  final RxList<Topping> topping = <Topping>[].obs;
  final RxList<Level> level = <Level>[].obs;

  Future observeMenu() async {
    try {
      final detailMenuResponse =
          await HttpService.dioService.getDetailMenu(itemIdMenu.value);
      if (detailMenuResponse?.data != null) {
        final dataMenu = detailMenuResponse?.data?.menu;
        final dataTopping = detailMenuResponse?.data?.topping;
        final dataLevel = detailMenuResponse?.data?.level;

        menu.value = dataMenu!;
        topping.value = dataTopping!;
        level.value = dataLevel!;
      }
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
    }
  }
}
