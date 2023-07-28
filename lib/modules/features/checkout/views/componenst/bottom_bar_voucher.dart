import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainee/configs/themes/main_color.dart';

class BottomBarVoucher extends StatelessWidget {
  const BottomBarVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 22.w,
      ),
      decoration: BoxDecoration(
        color: MainColor.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.r),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(111, 24, 24, 24),
            blurRadius: 15,
            spreadRadius: -1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const SizedBox(width: 10,),
              const Icon(
                Icons.check_circle_outline,
                size: 20,
              ),
              const SizedBox(width: 10,),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                      'Penggunaan voucher tidak dapat digabung dengan ',
                      style: GoogleFonts.montserrat(color: Colors.black, fontSize: 13.sp)
                    ),
                    Text(
                      'discount employee reward program',
                      style: GoogleFonts.montserrat(color: MainColor.primary, fontSize: 13.sp, fontWeight: FontWeight.bold)
                    ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                // Make the button rounded
                borderRadius:
                    BorderRadius.circular(50.r), // Adjust the radius as needed
                    
              ),
               minimumSize: Size(double.infinity, 40.h),
            ),
            child: Text(
              "Oke",
              textAlign: TextAlign.center,
              style: Get.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
