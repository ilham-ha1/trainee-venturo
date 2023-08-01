import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/global_models/cart.dart';
import 'package:trainee/modules/global_models/detail_menu_response.dart';
import 'package:trainee/utils/services/http_service.dart';
import 'package:trainee/utils/services/local_storage_service.dart';

class EditMenuController extends GetxController {
  static EditMenuController get to => Get.find<EditMenuController>();

  final RxInt itemIdMenu = 0.obs;

  final Rx<Level?> selectedLevel = Level().obs;
  final RxList<Topping?> selectedTopping = <Topping>[].obs;

  final RxList<int> idToppingSelected = <int>[].obs;
  final RxInt idLevelSelected = 0.obs;

  final RxInt qty = 1.obs;
  late RxString catatan;
  final Rx<Cart> cart = Cart().obs;
  final Rx<DataMenu> menu = DataMenu().obs;
  final RxList<Topping> topping = <Topping>[].obs;
  final RxList<Level> level = <Level>[].obs;

  late TextEditingController catatanDetailTextController;

  @override
  void onInit() async {
    super.onInit();
    catatanDetailTextController =
          TextEditingController();
    // Accessing the arguments passed to the controller
    // Accessing the arguments passed to the controller
    final arguments = Get.arguments as Map<String, dynamic>?;
    
    // Checking if arguments is not null and contains the 'carts' key
    if (arguments != null && arguments.containsKey('carts')) {
      final Cart cart = arguments['carts'] as Cart;

      // Accessing the 'Menu' argument and updating the 'menu' observable
      this.cart.value = cart;
      itemIdMenu.value = cart.id ?? 0;
      
      // You can access other properties from 'cart' and update other observables accordingly.
      final int qty = (cart.jumlah ?? 0) == 0 ? 1 : (cart.jumlah ?? 0);
      this.qty.value = qty;
      idToppingSelected.value = cart.topping!;
      idLevelSelected.value = cart.level ?? 0;
      catatanDetailTextController.text = cart.catatan ?? ''; // Set the catatan text in the text field

      final String catatan = arguments['catatan'] ?? '';
      catatanDetailTextController.text = catatan;
      this.catatan = catatanDetailTextController.text.obs;
      this.catatan.value = catatan;
    }

 
    await observeToppingAndLevel();
  }

  @override
  void onClose() {
    super.onClose();
    catatanDetailTextController.dispose();
  }

  Future saveToCart(Cart dataMenu) async {
    await LocalStorageService.saveCart(dataMenu);
  }

  int get totalPrice {
    // Calculate the total harga of selected toppings
    int selectedToppingHargaSum = 0;
    for (var topping in selectedTopping) {
      selectedToppingHargaSum += topping?.harga ?? 0;
    }

    // Calculate the total price
    return ((cart.value.harga ?? 0) +
            (selectedLevel.value?.harga ?? 0) +
            selectedToppingHargaSum) *
        qty.value;
  }

  //Menambahkan Jumlah
  void addMoreQuantity() {
    qty.value += 1;
  }

  //Mengurangi Jumlah
  void minMoreQuantity() {
    if (qty > 1) qty.value -= 1;
  }

  //Mendapatkan Data Menu
  Future<void> observeToppingAndLevel() async {
    try {
      final detailMenuResponse =
          await HttpService.dioService.getDetailMenu(itemIdMenu.value);
      if (detailMenuResponse?.data != null) {
        menu.value = detailMenuResponse!.data!.menu!;
        topping.value = detailMenuResponse.data!.topping!;
        level.value = detailMenuResponse.data!.level!;

        selectedLevel.value = level.firstWhere(
          (level) => level.idDetail == idLevelSelected.value,
          orElse: () {
            return Level();
          },
        );

        for (var idTopping in idToppingSelected) {
          Topping toppingSelected = topping.firstWhere(
            (element) => element.idDetail == idTopping,
            orElse: () {
              return Topping();
            },
          );

          if (toppingSelected.idDetail != null) {
            selectedTopping.add(toppingSelected);
          }
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
