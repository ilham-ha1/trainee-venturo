import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get to => Get.find();

  final TextEditingController emailCtrl = TextEditingController();
  var formKey = GlobalKey<FormState>();

  var emailValue = "".obs;
  void sendOtp() {
    if (formKey.currentState!.validate()) {
      emailValue.value = emailCtrl.text;
      Get.toNamed("/otp-input", arguments: emailCtrl.text);
    }
  }
}