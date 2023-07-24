import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/global_models/detail_menu_response.dart';
import 'package:trainee/utils/services/http_service.dart';

class MenuDetailController extends GetxController {
  static MenuDetailController get to => Get.find();

  final RxInt itemIdMenu = 0.obs;

  final Rx<Level?> selectedLevel = Level().obs;
  final Rx<Topping?> selectedTopping = Topping().obs;
  final RxInt qty = 1.obs;
  late RxString catatan;

  late TextEditingController catatanDetailTextController;
  @override
  void onInit() async {
    super.onInit();
    catatanDetailTextController = TextEditingController();
    itemIdMenu.value = Get.arguments;
    catatan = catatanDetailTextController.text.obs;
    await observeMenu();
  }

  @override
  void onClose() {
    super.onClose();
    catatanDetailTextController.dispose();
  }

  final Rx<Menu> menu = Menu().obs;
  final RxList<Topping> topping = <Topping>[].obs;
  final RxList<Level> level = <Level>[].obs;

  void addMoreQuantity() {
    qty.value += 1;
  }

  void minMoreQuantity() {
    if (qty > 1) qty.value -= 1;
  }

  Future observeMenu() async {
    try {
      final detailMenuResponse =
        await HttpService.dioService.getDetailMenu(itemIdMenu.value);
      if (detailMenuResponse?.data != null) {
        menu.value = detailMenuResponse!.data!.menu!;
        topping.value = detailMenuResponse.data!.topping!;
        level.value = detailMenuResponse.data!.level!;

        selectedTopping.value = topping.isNotEmpty ? topping.first : null;
        selectedLevel.value = level.isNotEmpty ? level.first : null;
      }
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
    }
  }
}
