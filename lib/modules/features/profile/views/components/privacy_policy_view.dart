import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/profile/controllers/profile_controller.dart';
import 'package:trainee/modules/features/profile/views/components/dialog_webview.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController.to.setCookie();
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy & Policy".tr),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse('https://venturo.id'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(
            const DialogWebview(),
          );
        },
        child: const Icon(Icons.open_in_new),
      ),
    );
  }
}