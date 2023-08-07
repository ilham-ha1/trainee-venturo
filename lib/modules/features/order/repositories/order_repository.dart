import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/global_models/user_order_detail_response.dart';
import 'package:trainee/modules/global_models/user_order_list_response.dart';
import 'package:trainee/utils/services/http_service.dart';

class OrderRepository {
  final List<UserOrderListData> ongoingOrder = [];

  //Get Order Data
  Future<void> getOrderData() async {
    try {
      final result = await HttpService.dioService.getUserOrderList();
      ongoingOrder.clear();
      ongoingOrder.addAll(result!.data!);
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  // Get Ongoing Order
  Future<Map<String, dynamic>> getOngoingOrder({int offset = 0}) async {
    int limit = 5 + offset;

    await getOrderData();
    var listOnGoingOrder =
        ongoingOrder.reversed.where((element) => element.status! < 3).toList();
    if (limit > listOnGoingOrder.length) limit = listOnGoingOrder.length;

    return {
      'data': listOnGoingOrder
          .getRange(offset, limit)
          .toList(),
      'next': limit < listOnGoingOrder.length ? true : null,
      'previous': offset > 0 ? true : null,
    };
  }

  // Get Order History
  Future<Map<String, dynamic>> getOrderHistory({int offset = 0}) async {
    int limit = 5 + offset;

    await getOrderData();
        var listHistoryOrder =
        ongoingOrder.reversed.where((element) => element.status! > 2).toList();
    if (limit > listHistoryOrder.length) limit = listHistoryOrder.length;

    return {
      'data': listHistoryOrder
          .getRange(offset, limit)
          .toList(),
      'next': limit < listHistoryOrder.length ? true : null,
      'previous': offset > 0 ? true : null,
    };
  }

  // Get Order Detail
  Future<UserOrderDetailData> getOrderDetail(int idOrder) async {
    try {
      final result = await HttpService.dioService.getUserOrderDetail(idOrder);
      if (result?.statusCode == 200) {
        final response = result?.data;
        if (response != null) {
          final orderData = response.order;

          var listDetail = <Detail>[];
          for (var data in response.detail!) {
            listDetail.add(data);
          }

          return UserOrderDetailData(order: orderData, detail: listDetail);
        } else {
          return UserOrderDetailData();
        }
      }
      return UserOrderDetailData();
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return UserOrderDetailData();
    }
  }
}
