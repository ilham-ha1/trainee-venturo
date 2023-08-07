import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      textRating?.value = 'Sempurna';
    } else if (rating >= 3.5) {
      textRating?.value = 'Bagus';
    } else if (rating >= 2.5) {
      textRating?.value = 'Cukup';
    } else if (rating >= 1.5) {
      textRating?.value = 'Buruk';
    } else {
      textRating?.value = 'Jelek';
    }
  }
}
