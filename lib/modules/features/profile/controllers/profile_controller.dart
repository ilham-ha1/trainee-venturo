import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trainee/configs/localization/localization.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/profile/repositories/profile_repository.dart';
import 'package:trainee/modules/features/profile/views/components/email_bottom_sheet.dart';
import 'package:trainee/modules/features/profile/views/components/language_bottom_sheet.dart';
import 'package:trainee/modules/features/profile/views/components/name_bottom_sheet.dart';
import 'package:trainee/modules/features/profile/views/components/pin_bottom_sheet.dart';
import 'package:trainee/modules/features/profile/views/components/telephone_bottom_sheet.dart';
import 'package:trainee/modules/global_models/logout_response.dart';
import 'package:trainee/modules/global_models/user_detail_profile.dart';
import 'package:trainee/shared/widgets/image_picker_dialog.dart';
import 'package:trainee/utils/services/http_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:trainee/utils/services/local_storage_service.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  final Rx<File?> _imageFile = Rx<File?>(null);

  File? get imageFile => _imageFile.value;

  RxString deviceModel = ''.obs;
  RxString deviceVersion = ''.obs;
  RxBool isVerif = false.obs;
  RxString currentLang = Localization.currentLanguage.obs;

  final Rx<UserDetailData> userDetailData = UserDetailData().obs;

  // Rx<Map<String, dynamic>> user = Rx<Map<String, dynamic>>({});

  late final ProfileRepository repository;

  @override
  void onInit() async {
    super.onInit();
    repository = ProfileRepository();
    await getDetailProfile();
    getDeviceInformation();
  }

  /// Pilih image untuk update photo
  Future<void> pickImage() async {
    /// Buka dialog untuk sumber gambar
    ImageSource? imageSource = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const ImagePickerDialog(),
    );

    /// pengecekan sumber gambar
    if (imageSource == null) return;

    final pickedFile = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 300,
      maxHeight: 300,
      imageQuality: 75,
    );

    /// setelah dipilih, akan terbuka crop gambar
    if (pickedFile != null) {
      _imageFile.value = File(pickedFile.path);
      final croppedFile = await ImageCropper()
          .cropImage(sourcePath: _imageFile.value!.path, aspectRatioPresets: [
        CropAspectRatioPreset.square
      ], uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper'.tr,
          toolbarColor: MainColor.primary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        )
      ]);

      /// Jika gambar telah dipilih, maka akan dimasukkan ke variabel image file, karena ini masih menggunakan local file
      if (croppedFile != null) {
        _imageFile.value = File(croppedFile.path);
      }

      // Read bytes from the file
      List<int> imageBytes = await _imageFile.value!.readAsBytes();

      // Convert bytes to base64-encoded string
      String base64string = base64.encode(imageBytes);

      await postUpdatePhoto(base64string);
    }
  }

  Future<void> postUpdatePhoto(String base64) async {
    final postUpdatePhotoResponse =
        await HttpService.dioService.postPhotoProfile(base64);
    if (postUpdatePhotoResponse?.statusCode == 200) {
      await getDetailProfile();
      Get.snackbar("Profile Photo".tr, "Success change profile photo".tr);
    } else {
      Get.snackbar("Profile Photo".tr, "Failed change profile photo".tr);
    }
  }

  Future<void> getDetailProfile() async {
    final getUserDetailResponse = await repository.getUserDetail();
    if (getUserDetailResponse.idUser != null) {
      userDetailData.value = getUserDetailResponse;
      if (userDetailData.value.ktp == null) {
        isVerif.value = false;
      } else {
        isVerif.value = true;
      }
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      // Read bytes from the file
      List<int> fileBytes = await file.readAsBytes();
      // Convert bytes to base64-encoded string
      String ktpBase64 = base64.encode(fileBytes);

      await postKtp(ktpBase64);
    }
  }

  Future getDeviceInformation() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceModel.value = androidInfo.model;
    deviceVersion.value = androidInfo.version.release;
  }

  Future<void> postKtp(String ktpBase64) async {
    final postKtpResponse = await HttpService.dioService.postKtp(ktpBase64);
    if (postKtpResponse?.statusCode == 200) {
      isVerif.value = true;
      await getDetailProfile();
      Get.snackbar("ID Card".tr, 'Success validate KTP'.tr);
    } else {
      isVerif.value = false;
      Get.snackbar("ID Card".tr, 'Failed validate KTP'.tr);
    }
  }

  Future<void> updateLanguage() async {
    String? language = await Get.bottomSheet(
      const LanguageBottomSheet(),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      isScrollControlled: true,
    );

    if (language != null) {
      Localization.changeLocale(language);
      currentLang(language);
    }
  }

  Future<void> postNameProfile(String name) async {
    final postProfileResponse =
        await HttpService.dioService.postNameProfile(name);
    if (postProfileResponse?.statusCode == 200) {
      await getDetailProfile();
      Get.snackbar("Update Profile".tr, "Success change profile".tr);
    } else {
      Get.snackbar("Update Profile".tr, "Failed change profile".tr);
    }
  }

  Future<void> updateProfileName() async {
    String? nameInput = await Get.bottomSheet(
      NameBottomSheet(nama: userDetailData.value.nama ?? '-'),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      isScrollControlled: true,
    );

    if (nameInput != null && nameInput.isNotEmpty) {
      await postNameProfile(nameInput);
    }
  }

  Future<void> postBirtdayProfile(DateTime birthday) async {
    final postProfileResponse =
        await HttpService.dioService.postBirtdayProfile(birthday);
    if (postProfileResponse?.statusCode == 200) {
      await getDetailProfile();
      Get.snackbar("Update Profile".tr, "Success change profile".tr);
    } else {
      Get.snackbar("Update Profile".tr, "Failed change profile".tr);
    }
  }

  Future<void> updateBirthDate() async {
    DateTime? birthDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime(DateTime.now().year - 21),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime.now(),
    );

    if (birthDate != null) {
      await postBirtdayProfile(birthDate);
    }
  }

  Future<void> updateProfileNumberPhone() async {
    String? phoneInput = await Get.bottomSheet(
      TelephoneBottomSheet(phoneNumber: userDetailData.value.telepon ?? '-'),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      isScrollControlled: true,
    );

    if (phoneInput != null && phoneInput.isNotEmpty) {
      await postNumberPhoneProfile(phoneInput);
    }
  }

  Future<void> postNumberPhoneProfile(String numberPhone) async {
    final postProfileResponse =
        await HttpService.dioService.postNumberPhoneProfile(numberPhone);
    if (postProfileResponse?.statusCode == 200) {
      await getDetailProfile();
      Get.snackbar("Update Profile".tr, "Success change profile".tr);
    } else {
      Get.snackbar("Update Profile".tr, "Failed change profile".tr);
    }
  }

  Future<void> updateProfileEmail() async {
    String? emailInput = await Get.bottomSheet(
      EmailBottomSheet(email: userDetailData.value.email ?? '-'),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      isScrollControlled: true,
    );

    if (emailInput != null && emailInput.isNotEmpty) {
      await postEmailProfile(emailInput);
    }
  }

  Future<void> postEmailProfile(String email) async {
    final postProfileResponse =
        await HttpService.dioService.postEmailProfile(email);
    if (postProfileResponse?.statusCode == 200) {
      await getDetailProfile();
      Get.snackbar("Update Profile".tr, "Success change profile".tr);
    } else {
      Get.snackbar("Update Profile".tr, "Failed change profile".tr);
    }
  }

  Future<void> updateProfilePin() async {
    String? pinInput = await Get.bottomSheet(
      PinBottomSheet(pin: userDetailData.value.pin ?? '-'),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      isScrollControlled: true,
    );

    if (pinInput != null && pinInput.isNotEmpty) {
      await postPinProfile(pinInput);
    }
  }

  Future<void> postPinProfile(String pin) async {
    final postProfileResponse =
        await HttpService.dioService.postPinProfile(pin);
    if (postProfileResponse?.statusCode == 200) {
      await getDetailProfile();
      Get.snackbar("Update Profile".tr, "Success change profile".tr);
    } else {
      Get.snackbar("Update Profile".tr, "Failed change profile".tr);
    }
  }

  Future<void> logout() async {
    final logoutResponse = await HttpService.dioService.logout();
    if (logoutResponse?.statusCode == 200) {
      LocalStorageService.deleteAuth();
      Get.offAllNamed(MainRoute.signIn);
    }
  }
}
