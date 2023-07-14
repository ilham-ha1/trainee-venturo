import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/counter/controllers/conter_controller.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
class ConterView extends StatelessWidget {
  const ConterView({super.key});
 static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: MainColor.primary,
          title: Text(
            "Conter App",
            style: GoogleFonts.roboto(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 10.w,
          ),
          child: Center(
            child: Text(
              "Jumlah Penambahan\n${ConterController.to.count.value}",
              style: GoogleFonts.roboto(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 18.sp,
          ),
          onPressed: () => ConterController.to.increment(),
        ),
      ),
    );
  }
}
