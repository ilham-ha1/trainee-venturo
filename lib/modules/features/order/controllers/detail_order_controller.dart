import 'dart:async';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/features/order/controllers/order_controller.dart';
import 'package:trainee/modules/global_models/user_order_detail_response.dart';
import 'package:trainee/utils/services/http_service.dart';

import '../repositories/order_repository.dart';

class DetailOrderController extends GetxController {
  static DetailOrderController get to => Get.find<DetailOrderController>();
  late final OrderRepository _orderRepository;

  // order data
  RxString orderDetailState = 'loading'.obs;
  Rxn<UserOrderDetailData> order = Rxn();
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    _orderRepository = OrderRepository();
    final orderId = int.parse(Get.parameters['orderId'] as String);

    getOrderDetail(orderId).then((value) {
      timer = Timer.periodic(
        const Duration(seconds: 10),
        (_) => getOrderDetail(orderId, isPeriodic: true),
      );
    });
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  Future<void> getOrderDetail(int orderId, {bool isPeriodic = false}) async {
    if (!isPeriodic) {
      orderDetailState('loading');
    }
    try {
      final result = await _orderRepository.getOrderDetail(orderId);

      orderDetailState('success');
      order(result);
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      orderDetailState('error');
    }
  }

  List<Detail> get foodItems =>
      order.value?.detail!
          .where((element) => element.kategori == 'makanan')
          .toList() ??
      [];

  List<Detail> get drinkItems =>
      order.value?.detail!
          .where((element) => element.kategori == 'minuman')
          .toList() ??
      [];

  Future<void> cancelOrder() async {
    final response = await HttpService.dioService
        .postCancelOrder(int.parse(Get.parameters['orderId'] as String));
    if (response?.statusCode == 200) {
      await _orderRepository.getOrderData();
      OrderController.to.getOngoingOrders();
      OrderController.to.getOrderHistories();
      Get.back();
    } else {
      Get.snackbar('Pesanan', 'Gagal Membatalkan Pesanan');
    }
  }
}
