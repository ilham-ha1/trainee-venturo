import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/checkout/controllers/checkout_controller.dart';
import 'package:trainee/modules/features/checkout/views/componenst/bottom_bar_voucher.dart';
import 'package:trainee/modules/features/checkout/views/componenst/rounded_app_bar.dart';
import 'package:trainee/modules/features/checkout/views/componenst/voucher_card.dart';

class VoucherView extends StatelessWidget {
  const VoucherView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: MainColor.white,
          appBar: RoundedAppBar(
            title: 'Pilih Voucher',
            icon: Icons.card_giftcard,
            titleStyle: GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          body: Column(
            children: [
              Expanded(
                  child: Obx(() => ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        itemBuilder: (contex, index) {
                          final voucher = CheckoutController.to.voucher[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.5.h),
                            child: Material(
                                borderRadius: BorderRadius.circular(20.r),
                                elevation: 2,
                                child: VoucherCard(
                                  voucher: voucher,
                                  index: index,
                                  onTap: () {
                                    Get.toNamed(MainRoute.detailVoucher,
                                        arguments: voucher);
                                  },
                                )),
                          );
                        },
                        itemCount: CheckoutController.to.voucher.length,
                      )))
            ],
          ),
          bottomNavigationBar: const BottomBarVoucher()),
    );
  }
}
