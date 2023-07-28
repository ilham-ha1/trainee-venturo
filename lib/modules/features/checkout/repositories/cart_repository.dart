import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/global_models/user_discount_response.dart';
import 'package:trainee/modules/global_models/user_voucher_response.dart';
import 'package:trainee/utils/services/http_service.dart';

class CartRepository {

  final RxList<Discount> discount = <Discount>[].obs;
  final RxList<Voucher> voucher = <Voucher>[].obs;

  Future<Discount> getDiscount() async {
    try {
      final discountResponse = await HttpService.dioService.getUserDiscount();
      discount.clear();
      if (discountResponse?.data != null) {
        discount.addAll(discountResponse!.data!.toList());
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
    return Discount();
  }

  Future<Voucher> getVoucher() async {
    try {
      final voucherResponse = await HttpService.dioService.getUserVoucher();
      voucher.clear();
      if (voucherResponse?.data != null) {
        voucher.addAll(voucherResponse!.data!.toList());
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
    return Voucher();
  }


}
