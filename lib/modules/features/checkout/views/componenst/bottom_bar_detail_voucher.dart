import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/checkout/controllers/checkout_controller.dart';
import 'package:trainee/modules/global_models/user_voucher_response.dart';
import 'package:trainee/shared/styles/elevated_button_style.dart';

class BottomBarDetailVoucher extends StatelessWidget {
  const BottomBarDetailVoucher({super.key, required this.voucher});

  final Voucher voucher;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: MainColor.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.r),
        ),
        boxShadow: const [
          BoxShadow(
            color: MainColor.black,
            blurRadius: 15,
            spreadRadius: -1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          CheckoutController.to.selectedVoucher(voucher);
          CheckoutController.to.addDataVoucher();
          Get.offAndToNamed(MainRoute.checkout);
        },
        style: EvelatedButtonStyle.mainRounded.copyWith(
          backgroundColor: MaterialStateProperty.all<Color>(
            MainColor.primary,
          ),
        ),
        child: Text('Use Voucher'.tr,
            style: GoogleFonts.montserrat(
                fontSize: 16.sp,
                color: MainColor.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
