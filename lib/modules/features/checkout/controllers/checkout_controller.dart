import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/checkout/repositories/cart_repository.dart';
import 'package:trainee/modules/features/checkout/views/componenst/discount_dialog.dart';
import 'package:trainee/modules/features/checkout/views/componenst/fingerprint_dialog.dart';
import 'package:trainee/modules/features/checkout/views/componenst/order_success_dialog.dart';
import 'package:trainee/modules/features/checkout/views/componenst/pin_dialog.dart';
import 'package:trainee/modules/global_models/cart.dart';
import 'package:trainee/modules/global_models/user_discount_response.dart';
import 'package:trainee/modules/global_models/user_voucher_response.dart';
import 'package:trainee/utils/services/http_service.dart';
import 'package:trainee/utils/services/local_storage_service.dart';

class CheckoutController extends GetxController {
  static CheckoutController get to => Get.find<CheckoutController>();

  final RxList<Cart> cart = <Cart>[].obs;
  final RxString cartViewState = 'success'.obs;
  late final CartRepository repository;

  final TextEditingController catatanDetailTextController =
      TextEditingController();

  final RxList<Voucher> voucher = <Voucher>[
    Voucher(
      idVoucher: 1,
      nama: "Koordinator Program kekompakan",
      idUser: 1,
      nominal: 50000,
      infoVoucher: "https://i.ibb.co/bJ10gcZ/Voucher-Java-Code-app-01.jpg",
      periodeMulai: 1610038000,
      periodeSelesai: 1613516400,
      type: 1,
      status: 1,
      catatan:
          "loreasfi sofnsaiosaogi sagsagsaogisaj gsaaiosgnasoigsa safsajfoais sagfsaoifjsa",
      selected: false,
    ),
    Voucher(
      idVoucher: 2,
      nama: "Friend Referal Recrutiment",
      idUser: 47,
      nominal: 25000,
      infoVoucher: "https://i.ibb.co/bJ10gcZ/Voucher-Java-Code-app-01.jpg",
      periodeMulai: 1610038000,
      periodeSelesai: 1613516400,
      type: 0,
      status: 1,
      catatan:
          "asifjsaifsajoi safosajfosaijfsag sag sag sagsag sag  asg saga sga s sag sag sa fewf e ",
      selected: false,
    ),
    Voucher(
      idVoucher: 3,
      nama: "Weekend",
      idUser: 47,
      nominal: 25000,
      infoVoucher: "https://i.ibb.co/bJ10gcZ/Voucher-Java-Code-app-01.jpg",
      periodeMulai: 1610038000,
      periodeSelesai: 1613516400,
      type: 0,
      status: 1,
      catatan:
          "asifjsaiafsasasfsajoi safosajfosaijfsag sag sag sagsag sag  asg saga sga s sag sag sa fewf e ",
      selected: false,
    ),
  ].obs;

  final Rx<Voucher> selectedVoucher = Voucher().obs;
  final RxList<Discount> discount = <Discount>[
    Discount(
      idDiskon: 1,
      idUser: 1,
      namaUser: "Super Admin",
      nama: "Mengisi survey",
      diskon: 10,
    ),
    Discount(
      idDiskon: 1,
      idUser: 1,
      namaUser: "Super Admin",
      nama: "Mengisi survey",
      diskon: 10,
    )
  ].obs;
  RxInt totalDiscount = 0.obs;
  RxBool isVoucherSelected = false.obs;

  RxInt totalVoucher = 0.obs;
  RxString voucherName = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    repository = CartRepository();
    await fetchData();
    await getVoucherData();
    await getDiscountData();
  }

  Future<void> fetchData() async {
    try {
      cartViewState('loading');
      final result = await LocalStorageService.getAllCarts();
      cart.addAll(result);
      cartViewState('success');
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      cartViewState('error');
    }
  }

  void increaseQty(Cart item) {
    item.jumlah++;
    cart.refresh();
  }

  void decreaseQty(Cart item) async {
    item.jumlah--;
    if (item.jumlah == 0) {
      deleteItem(item.id);
    }
    cart.refresh();
  }

  // Get food items
  List<Cart> get foodItems =>
      cart.where((e) => e.kategori == 'makanan').toList();

  /// Get drink items
  List<Cart> get drinkItems =>
      cart.where((e) => e.kategori == 'minuman').toList();

  // calculate total price of all item
  int get totalPrice =>
      cart.fold(0, (prevTotal, item) => prevTotal + (item.harga) * item.jumlah);

  // calculate discount price
  void calculateDiscount() {
    for (var discountData in discount) {
      totalDiscount.value = totalDiscount.value + discountData.diskon!;
    }
  }

  int get discountPrice {
    if (selectedVoucher.value.idVoucher != null) {
      // If a voucher is selected, return 0
      return 0;
    } else {
      // Calculate the discount price
      if (totalDiscount.value != 0) {
        return totalPrice ~/ totalDiscount.value;
      } else {
        return 0;
      }
    }
  }

  // calculate final price
  int get grandTotalPrice {
    int calculatedGrandTotal = totalPrice - discountPrice - totalVoucher.value;
    return calculatedGrandTotal < 0 ? 0 : calculatedGrandTotal;
  }

  Future<void> verify() async {
    // check supported auth type in device
    final LocalAuthentication localAuth = LocalAuthentication();
    final bool canCheckBiometrics = await localAuth.canCheckBiometrics;
    final bool isBiometricSupported = await localAuth.isDeviceSupported();

    if (canCheckBiometrics && isBiometricSupported) {
      // open fingerprint dialog if supported
      final String? authType = await showFingerprintDialog();

      if (authType == 'fingerprint') {
        // fingerprint auth flow
        final bool authenticated = await localAuth.authenticate(
          localizedReason: 'Please authenticate to confirm order'.tr,
          options: const AuthenticationOptions(
            biometricOnly: true,
          ),
        );

        // if succeed, order cart
        if (authenticated) {
          showOrderSuccessDialog();
        }
      } else if (authType == 'pin') {
        // pin auth flow
        await showPinDialog();
      }
    } else {
      await showPinDialog();
    }
  }

  Future<String?> showFingerprintDialog() async {
    // ensure all modal is closed before show fingerprint dialog
    Get.until(ModalRoute.withName(MainRoute.checkout));
    final result = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const FingerprintDialog(),
    );

    return result;
  }

  Future<void> showDiscountDialog() async {
    Get.until(ModalRoute.withName(MainRoute.checkout));
    try {
      await Get.defaultDialog(
        title: '',
        titleStyle: const TextStyle(fontSize: 0),
        content: const DiscountDialog(),
      );
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      cartViewState('error');
    }
  }

  Future<void> showPinDialog() async {
    // ensure all modal is closed before show pin dialog
    Get.until(ModalRoute.withName(MainRoute.checkout));

    const userPin = '123456';

    final bool? authenticated = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const PinDialog(pin: userPin),
    );

    if (authenticated == true) {
      // if succeed, order cart
      showOrderSuccessDialog();
    } else if (authenticated != null) {
      // if failed 3 times, show order failed dialog
      Get.until(ModalRoute.withName(MainRoute.checkout));
    }
  }

  Future<void> showOrderSuccessDialog() async {
    Get.toNamed(MainRoute.checkout);
    await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const OrderSuccessDialog(),
    );

    Get.back();
  }

  void deleteItem(int id) {
    LocalStorageService.deleteItemOnCart(id);
    cart.removeWhere((e) => e.id == id);
  }

  Future<void> getVoucherData() async {
    final dataVoucher = await HttpService.dioService.getUserVoucher();

    if (dataVoucher?.statusCode == 200) {
      voucher.clear();
      voucher.addAll(dataVoucher!.data!);
    }
  }

  Future<void> getDiscountData() async {
    final dataDiscount = await HttpService.dioService.getUserDiscount();

    if (dataDiscount?.statusCode == 200) {
      discount.clear();
      discount.addAll(dataDiscount!.data!);
      calculateDiscount();
    }
    calculateDiscount();
  }

  void manageVoucherCheckBox(int index, bool isSelected) {
    isVoucherSelected.value = false;

    for (var data in voucher) {
      if (voucher.indexOf(data) == index) {
        voucher[voucher.indexOf(data)].selected = isSelected;
        if (isSelected == true) {
          selectedVoucher.value = voucher[voucher.indexOf(data)];
          isVoucherSelected.value = true;
        } else {
          selectedVoucher.value = Voucher();
        }
      } else {
        voucher[voucher.indexOf(data)].selected = false;
      }
    }
    if (!isVoucherSelected.value) {
      //false
      // Set to false if no voucher is selected
      totalVoucher.value = 0;
      voucherName.value = '';
    }
  }

  void addDataVoucher() {
    totalVoucher.value = selectedVoucher.value.nominal!;
    voucherName.value = selectedVoucher.value.nama!;
  }
}
