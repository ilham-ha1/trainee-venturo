import 'package:get/get.dart';
import 'package:trainee/modules/global_models/cart.dart';
import 'package:trainee/utils/services/local_storage_service.dart';

class MenuCartControlller extends GetxController {
  static MenuCartControlller get to => Get.find();
  //variabel untuk menyimpan data dari detail menu katalog
  final RxList<Cart> cartDataItem = <Cart>[].obs;

  @override
  void onReady() async {
    super.onReady();
    await getCart();
  }
  
  //untuk menyimpan ke keranjang
  Future saveToCart(Cart dataMenu) async {
    cartDataItem.add(dataMenu);
    await LocalStorageService.saveCart(cartDataItem.toList());
  }

  //untuk mendapatkan data dari pelanggan
  Future<void> getCart() async {
    final List<Cart> loadCartDataItems = await LocalStorageService.getCart();
    cartDataItem.addAll(loadCartDataItems);
  }
  
}
