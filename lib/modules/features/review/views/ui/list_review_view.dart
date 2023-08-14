import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/constants/commons/asset_const.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:trainee/modules/features/review/controllers/list_review_controller.dart';
import 'package:trainee/modules/features/review/views/components/review_card.dart';

class ListReviewView extends StatelessWidget {
  const ListReviewView({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'List Review Screen',
      screenClassOverride: 'Trainee',
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'List Review'.tr,
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: MainColor.black,
              decoration: TextDecoration.underline),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.r),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: MainColor.black), // Back button icon
          onPressed: () {
            // Add your navigation logic here
            Get.back();
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AssetConst.bgPattern2),
              fit: BoxFit.fitHeight,
              alignment: Alignment.center),
        ),
        child: Obx(()=> ListView.separated(
            padding: EdgeInsets.all(25.r),
            itemBuilder: (context, index) => ReviewItemCard(
              review: ListReviewController.to.userListReviewlData[index],
              onTap: () {
                // Get.toNamed(
                //   '${MainRoute.detailReview}/${ListReviewController.to.userListReviewlData[index].idReview}',
                // );
              },
            ),
            separatorBuilder: (context, index) => 16.verticalSpace,
            itemCount: ListReviewController.to.userListReviewlData.length,
          ),
        ),
      ),
    );
  }
}
