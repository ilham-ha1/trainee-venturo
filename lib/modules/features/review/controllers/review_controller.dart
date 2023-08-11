import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/global_models/user_add_review_body.dart';
import 'package:trainee/utils/services/http_service.dart';
import 'package:trainee/utils/services/local_storage_service.dart';

class ReviewController extends GetxController {
  static ReviewController get to => Get.find<ReviewController>();

  final RxList<String> chip = <String>[
    'Harga',
    'Rasa',
    'Penyajian Makanan',
    'Pelayanan',
    'Fasilitas'
  ].obs;

  final RxString? selectedChip = ''.obs;
  final RxDouble? rating = 0.0.obs;
  final RxString? textRating = ''.obs;
  final RxString? base64File = ''.obs;

  late RxString catatan;
  late TextEditingController catatanReview;

  @override
  void onInit() async {
    super.onInit();
    catatan = ''.obs;
    catatanReview = TextEditingController();
    rating?.listen((value) {
      updateTextRating(value);
    });

    catatanReview.addListener(() {
      catatan.value = catatanReview.text;
    });
  }

  @override
  void onClose() {
    super.onClose();
    catatanReview.dispose();
  }

  void changeRating(double rating) {
    this.rating?.value = rating;
    updateTextRating(rating);
  }

  void updateTextRating(double rating) {
    if (rating >= 4.5) {
      textRating?.value = 'Perfect'.tr;
    } else if (rating >= 3.5) {
      textRating?.value = 'Almost Perfect'.tr;
    } else if (rating >= 2.5) {
      textRating?.value = 'Good'.tr;
    } else if (rating >= 1.5) {
      textRating?.value = 'Bad'.tr;
    } else {
      textRating?.value = 'Worse'.tr;
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      // Read bytes from the file
      List<int> fileBytes = await file.readAsBytes();
      // Convert bytes to base64-encoded string
      base64File?.value = base64.encode(fileBytes);
    }
  }

  Future<void> addReview() async {
    final idUser = LocalStorageService.getId();
    final reviewBody = UserAddReviewBody(
        idUser: idUser,
        image: base64File?.value,
        review: catatan.value,
        score: rating?.value,
        type: selectedChip?.value);
    final addReviewResponse =
        await HttpService.dioService.addReview(reviewBody);
    if (addReviewResponse?.data == null) {
      base64File?.value = '';
      selectedChip?.value = '';
      rating?.value = 0.0;
      catatan.value = '';
      Get.snackbar("Review".tr, 'Success to add review'.tr);
    } else {
      Get.snackbar("Review".tr, 'Failed to add review'.tr);
    }
  }
}
