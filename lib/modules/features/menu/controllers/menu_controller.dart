import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/global_models/cart.dart';
import 'package:trainee/modules/global_models/detail_menu_response.dart';
import 'package:trainee/utils/services/http_service.dart';
import 'package:trainee/utils/services/local_storage_service.dart';

class MenuDetailController extends GetxController {
  static MenuDetailController get to => Get.find();

  final RxInt itemIdMenu = 0.obs;

  final Rx<Level?> selectedLevel = Level().obs;
  final Rx<Topping?> selectedTopping = Topping().obs;
  final RxInt qty = 1.obs;
  late RxString catatan;
  final Rx<Menu> menu = Menu().obs;
  final RxList<Topping> topping = <Topping>[].obs;
  final RxList<Level> level = <Level>[].obs;

  late TextEditingController catatanDetailTextController;
  @override
  void onInit() async {
    super.onInit();
    catatanDetailTextController = TextEditingController();

    // Accessing the arguments passed to the controller
    final arguments = Get.arguments as Map<String, dynamic>?;
    // Checking if arguments is not null
    if (arguments != null) {
      // Accessing the 'idMenu' argument
      itemIdMenu.value = arguments['idMenu'] ?? 0;
      // Accessing the 'qty' argument
      final int qty = arguments['qty'] == 0 ? 1 : arguments['qty'];
      this.qty.value = qty;
      // Accessing the 'catatan' argument
      final String catatan = arguments['catatan'] ?? '';
      catatanDetailTextController.text = catatan;
      this.catatan = catatanDetailTextController.text.obs;
      this.catatan.value = catatan;
    }

    await observeMenu();
  }

  @override
  void onClose() {
    super.onClose();
    catatanDetailTextController.dispose();
  }

  //untuk menyimpan ke keranjang
  final RxList<Cart> itemsCart = <Cart>[].obs;
  Future saveToCart(Cart dataMenu) async {
    await LocalStorageService.saveCart(dataMenu);
  }

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
