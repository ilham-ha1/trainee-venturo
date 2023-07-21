import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/global_models/detail_promo_response.dart';
import 'package:trainee/utils/services/http_service.dart';

class PromoController extends GetxController {
  static PromoController get to => Get.find();

  final RxInt itemidPromo = 0.obs;

  @override
  void onInit() async{
    super.onInit();
    itemidPromo.value = Get.arguments;
    await observePromos();
  }

  final Rx<DetailPromo> detailPromo = DetailPromo().obs;

  Future observePromos() async {
    try {
      final detailPromoResponse =
          await HttpService.dioService.getDetailUserPromo(itemidPromo.value);
      if (detailPromoResponse?.data != null) {
        detailPromo.value = DetailPromo(
         idPromo: detailPromoResponse!.data!.idPromo,
          nama: detailPromoResponse.data!.nama,
          diskon: detailPromoResponse.data!.diskon,
          nominal: detailPromoResponse.data!.nominal,
          kadaluarsa: detailPromoResponse.data!.kadaluarsa,
          syaratKetentuan: detailPromoResponse.data!.syaratKetentuan,
          foto: detailPromoResponse.data!.foto
        );
      }
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
    }
  }

}
