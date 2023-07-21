import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../global_models/detail_menu_response.dart';

class UserOrderController extends GetxController {
  static UserOrderController get to => Get.find();

  final Rx<Level?> selectedLevel = Level().obs;
  final Rx<Topping?> selectedTopping = Topping().obs;
  final RxInt qty = 1.obs;
  late RxString catatan;

  TextEditingController? catatanTextController;

  @override
  void onInit() {
    super.onInit();
     catatanTextController = TextEditingController();
     catatan = catatanTextController!.text.obs;
  }

  @override
  void onClose() {
    super.onClose();
    catatanTextController?.dispose();
  }

  void selectLevel(String level){
    
  }

  void addMoreQuantity() {
    qty.value += 1;
  }

  void minMoreQuantity() {
    if (qty > 1) qty.value -= 1;
  }

}
