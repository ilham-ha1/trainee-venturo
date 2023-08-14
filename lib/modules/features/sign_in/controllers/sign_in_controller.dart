import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/constants/cores/api/api_constant.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:trainee/shared/styles/google_text_style.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/utils/services/http_service.dart';
import 'package:trainee/utils/services/local_storage_service.dart';

class SignInController extends GetxController {
  static SignInController get to => Get.find();

  /// Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  /// Form Variable Setting
  var formKey = GlobalKey<FormState>();
  var emailCtrl = TextEditingController();
  var emailValue = "".obs;
  var passwordCtrl = TextEditingController();
  var passwordValue = "".obs;
  var isPassword = true.obs;
  var isRememberMe = false.obs;

  /// Form Password Show
  void showPassword() {
    if (isPassword.value == true) {
      isPassword.value = false;
    } else {
      isPassword.value = true;
    }
  }

  /// Form Validate & Submited
  void validateForm(context) async {
    await GlobalController.to.checkConnection();

    var isValid = formKey.currentState!.validate();
    Get.focusScope!.unfocus();

    if (isValid && GlobalController.to.isConnect.value == true) {
      EasyLoading.show(
        status: 'Sedang Diproses...',
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false,
      );

      formKey.currentState!.save();

      try {
        final response = await HttpService.dioService.login(
          emailCtrl.text,
          passwordCtrl.text,
        );

        if (response!.statusCode == 200) {
          EasyLoading.dismiss();
          LocalStorageService.setAuth(response.data);
          Get.offAllNamed(MainRoute.getLocation);
        } else {
          EasyLoading.dismiss();
          PanaraInfoDialog.show(
            context,
            title: "Warning",
            message: "Email & Password Salah",
            buttonText: "Coba lagi",
            onTapDismiss: () {
              Get.back();
            },
            panaraDialogType: PanaraDialogType.warning,
            barrierDismissible: false,
          );
        }
      } catch (error) {
        EasyLoading.dismiss();
        Get.snackbar(
          "Error",
          "Failed to make login request. Please try again later.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else if (GlobalController.to.isConnect.value == false) {
      Get.toNamed(MainRoute.noConnection);
    }
  }

  /// Flavor setting
  void flavorSeting() async {
    Get.bottomSheet(
      Obx(
        () => Wrap(
          children: [
            Container(
              width: double.infinity.w,
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
                vertical: 5.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: MainColor.white,
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      GlobalController.to.isStaging.value = false;
                      GlobalController.to.baseUrl = ApiConstant.production;
                    },
                    title: Text(
                      "Production",
                      style: GoogleTextStyle.fw400.copyWith(
                        color: GlobalController.to.isStaging.value == true
                            ? MainColor.black
                            : MainColor.primary,
                        fontSize: 14.sp,
                      ),
                    ),
                    trailing: GlobalController.to.isStaging.value == true
                        ? null
                        : Icon(
                            Icons.check,
                            color: MainColor.primary,
                            size: 14.sp,
                          ),
                  ),
                  Divider(
                    height: 1.h,
                  ),
                  ListTile(
                    onTap: () {
                      GlobalController.to.isStaging.value = true;
                      GlobalController.to.baseUrl = ApiConstant.staging;
                    },
                    title: Text(
                      "Staging",
                      style: GoogleTextStyle.fw400.copyWith(
                        color: GlobalController.to.isStaging.value == true
                            ? MainColor.primary
                            : MainColor.black,
                        fontSize: 14.sp,
                      ),
                    ),
                    trailing: GlobalController.to.isStaging.value == true
                        ? Icon(
                            Icons.check,
                            color: MainColor.primary,
                            size: 14.sp,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signInWithGoogle() async {
    try {
      GlobalController.to.checkConnection();
      if (GlobalController.to.isConnect.isTrue) {
        GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

        if (googleSignInAccount != null) {
          GoogleSignInAuthentication googleSignInAuthentication =
              await googleSignInAccount.authentication;

          AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );

          await _auth.signInWithCredential(credential);
          final response = await HttpService.dioService.loginWithGmail( //issue
            googleSignInAccount.email,
            googleSignInAccount.displayName!,
          );

          await LocalStorageService.setAuth(response!.data);
          if(LocalStorageService.isLoggedIn()){
            await Get.offAndToNamed(MainRoute.getLocation);
          }
        }
      }
    } catch (exception, stackTrace) {
      Get.snackbar(
        "Error Gmail Sign In",
        exception.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }
}
