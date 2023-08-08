import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/profile/repositories/profile_repository.dart';
import 'package:trainee/modules/global_models/user_detail_profile.dart';
import 'package:trainee/shared/widgets/image_picker_dialog.dart';
import 'package:trainee/utils/services/http_service.dart';
import 'package:trainee/modules/global_models/user_update_photo_profile.dart';
import 'package:device_info_plus/device_info_plus.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  final Rx<File?> _imageFile = Rx<File?>(null);

  File? get imageFile => _imageFile.value;

  RxString deviceModel = ''.obs;
  RxString deviceVersion = ''.obs;
  RxBool isVerif = false.obs;

  final Rx<UserProfileData> userProfileData = UserProfileData().obs;
  final Rx<UserDetailData> userDetailData = UserDetailData().obs;

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
      userProfileData.value =
          postUpdatePhotoResponse?.profileData ?? UserProfileData();
      await getDetailProfile();
      Get.snackbar("Foto Profile", "Berhasil Mengganti Foto Profile");
    } else {
      Get.snackbar("Foto Profile", "Gagal Mengganti Foto Profile");
    }
  }

  Future<void> getDetailProfile() async {
    final getUserDetailResponse = await repository.getUserDetail();
    if (getUserDetailResponse.idUser != null) {
      userDetailData.value = getUserDetailResponse;
      if(userDetailData.value.ktp == null){
        isVerif.value = false;
      }else{
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
      Get.snackbar("Ktp", "Berhasil validasi Ktp");
    } else {
      isVerif.value = false;
      Get.snackbar("Ktp", "Gagal validasi Ktp");
    }
  }
}
