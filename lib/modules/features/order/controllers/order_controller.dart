import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/features/order/repositories/order_repository.dart';
import 'package:trainee/modules/global_models/user_order_list_response.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find<OrderController>();
  late final OrderRepository _orderRepository;

  @override
  void onInit() async{
    super.onInit();
    _orderRepository = OrderRepository();
    await _orderRepository.getOrderData();
    getOngoingOrders();
    getOrderHistories();
  }

  RxList<UserOrderListData> onGoingOrders = RxList();
  RxList<UserOrderListData> historyOrders = RxList();
  RxString onGoingOrderState = 'loading'.obs;
  RxString orderHistoryState = 'loading'.obs;

  Rx<String> selectedCategory = 'all'.obs;

  //pagination variabel OnGoing
  final RxBool canLoadMoreOnGoing = true.obs;
  final RxInt pageOnGoing = 0.obs;
  final RefreshController refreshControllerOnGoing =
      RefreshController(initialRefresh: false);

  //pagination variabel History
  final RxBool canLoadMoreHistory = true.obs;
  final RxInt pageHistory = 0.obs;
  final RefreshController refreshControllerHistory =
      RefreshController(initialRefresh: false);

  void onRefreshOnGoing() async {
    pageOnGoing(0);
    canLoadMoreOnGoing(true);
    final result = await getOngoingOrders();
    if (result) {
      refreshControllerOnGoing.refreshCompleted();
    } else {
      refreshControllerOnGoing.refreshFailed();
    }
  }

   void onRefreshHistory() async {
    pageHistory(0);
    canLoadMoreHistory(true);
    final result = await getOrderHistories();
    if (result) {
      refreshControllerHistory.refreshCompleted();
    } else {
      refreshControllerHistory.refreshFailed();
    }
  }

  Map<String, String> get dateFilterStatus => {
        'all': 'All status'.tr,
        'completed': 'Completed'.tr,
        'canceled': 'Canceled'.tr,
      };

  Rx<DateTimeRange> selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  Future<bool> getOngoingOrders() async {
    onGoingOrderState('loading');
    try {
      final result = await _orderRepository.getOngoingOrder(offset: pageOnGoing.value * 5);

      if (result['previous'] == null) {
        onGoingOrders.clear();
      }

      if (result['next'] == null) {
        canLoadMoreOnGoing(false);
        refreshControllerOnGoing.loadNoData();
      }

      final data = result['data'].where((element) => element.status != 4).toList();
      onGoingOrders.addAll(data.toList());

      pageOnGoing.value++;
      refreshControllerOnGoing.loadComplete();
      onGoingOrderState('success');
      return true;
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      refreshControllerOnGoing.loadFailed();
      onGoingOrderState('error');
      return false;
    }
  }

  Future<bool> getOrderHistories() async {
    orderHistoryState('loading');
    try {
      final result = await _orderRepository.getOrderHistory();

      if (result['previous'] == null) {
        historyOrders.clear();
      }

      if (result['next'] == null) {
        canLoadMoreHistory(false);
        refreshControllerHistory.loadNoData();
      }
    
      historyOrders.addAll(result['data'].toList());

      pageHistory.value++;
      refreshControllerHistory.loadComplete();
      orderHistoryState('success');
       return true;
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
       refreshControllerHistory.loadFailed();
      orderHistoryState('error');
         return false;
    }
  }

  void setDateFilter({String? category, DateTimeRange? range}) {
    selectedCategory(category);
    selectedDateRange(range);
  }

  List<UserOrderListData> get filteredHistoryOrder {
    final historyOrderList = historyOrders.toList();

    if (selectedCategory.value == 'canceled') {
      historyOrderList.removeWhere((element) => element.status != 4);
    } else if (selectedCategory.value == 'completed') {
      historyOrderList.removeWhere((element) => element.status != 3);
    }

     historyOrderList.removeWhere((element) =>
      element.tanggal!.isBefore(selectedDateRange.value.start) ||
      element.tanggal!.isAfter(selectedDateRange.value.end));

    historyOrderList.sort((a, b) => b.tanggal 
        !.compareTo(a.tanggal!));

    return historyOrderList;
  }

  String get totalHistoryOrder {
    final total = filteredHistoryOrder.where((e) => e.status == 3).fold(0,
        (previousValue, element) => previousValue + (element.totalBayar ?? 0));

    return total.toString();
  }
}
