import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/checkout/controllers/checkout_controller.dart';

class DiscountDialog extends StatelessWidget {
  const DiscountDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Info Diskon'.tr,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  color: MainColor.primary,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 15.h),
              Obx(
                () {
                  if (CheckoutController.to.discount.isNotEmpty) {
                    List<Widget> discountWidgets = <Widget>[];
                    for (var discount in CheckoutController.to.discount) {
                      discountWidgets.add(
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      discount.nama!,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12.sp,
                                        color: MainColor.black,
                                      ),
                                    ),
                                    
                                    Text(
                                      '${discount.diskon!.toString()}%',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                        color: MainColor.black,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                              
                      );
                    }
                    return Column(
                      children: discountWidgets,
                    );
                  } else {
                    return const Center(
                      child: Text("Tidak ada diskon yang tersedia"),
                    );
                  }
                },
              ),
              SizedBox(height: 15.h),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
                  child: Text(
                    "Oke",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w800,
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
