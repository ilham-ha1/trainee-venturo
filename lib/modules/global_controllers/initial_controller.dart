
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/initial/views/ui/get_location_screen.dart';
import 'package:trainee/utils/services/local_storage_service.dart';
import 'package:trainee/utils/services/location_service.dart';

class InitialController extends GetxController {
  static InitialController get to => Get.find();

  RxInt id = 0.obs;
  RxString name = ''.obs;
  RxString photo = ''.obs;

  @override
  void onReady() {
    super.onReady();

    getLocation();
    LocationServices.streamService.listen((status) => getLocation());

    id.value = LocalStorageService.box.get("id")?? 0;
    name.value = LocalStorageService.box.get("name") ?? '';
    photo.value = LocalStorageService.box.get("photo") ?? '';
  }

  /// Location
  RxString statusLocation = RxString('loading');
  RxString messageLocation = RxString('');
  Rxn<Position> position = Rxn<Position>();
  RxnString address = RxnString();

  Future<void> getLocation() async {
    if (Get.isDialogOpen == false) {
      Get.dialog(const GetLocationScreen(), barrierDismissible: false);
    }

    try {
      /// Mendapatkan Lokasi saat ini
      statusLocation.value = 'loading';
      final locationResult = await LocationServices.getCurrentPosition();

      if (locationResult.success) {
        /// Jika jarak lokasi cukup dekat, dapatkan informasi alamat
        position.value = locationResult.position;
        address.value = locationResult.address;
        statusLocation.value = 'success';

        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(MainRoute.initial);
      } else {
        /// Jika jarak lokasi tidak cukup dekat, tampilkan pesan
        statusLocation.value = 'error';
        messageLocation.value = locationResult.message!;
      }
    } catch (e) {
      /// Jika terjadi kesalahan server
      statusLocation.value = 'error';
      messageLocation.value = 'Server error'.tr;
    }
  }
}
