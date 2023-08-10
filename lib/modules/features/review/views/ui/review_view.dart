import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/modules/features/review/controllers/review_controller.dart';
import 'package:trainee/modules/features/review/views/components/review_chip.dart';

class ReviewView extends StatelessWidget {
  const ReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: MainColor.black,
            ),
            onPressed: () {
              Get.back(); // If you're using GetX for navigation
            },
          ),
          title: Text(
            'Review'.tr,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: MainColor.black,
              decoration: TextDecoration.underline,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30.r),
            ),
          ),
        ),
        body: Stack(
          // Use Stack to overlay the background image container
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageConstant.bg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Obx(
              () => SingleChildScrollView(
                // Wrap the Column with SingleChildScrollView to make it scrollable
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 30.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          color: Colors.grey[100],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Give Review!'.tr,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                RatingBar(
                                  initialRating: 0,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  ratingWidget: RatingWidget(
                                    full: const Icon(Icons.star,
                                        color: Colors.orange),
                                    half: const Icon(Icons.star_half,
                                        color: Colors.orange),
                                    empty: const Icon(Icons.star_border,
                                        color: Colors.orange),
                                  ),
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  onRatingUpdate: (rating) {
                                    ReviewController.to.changeRating(rating);
                                  },
                                ),
                                const Spacer(),
                                Text(
                                  ReviewController.to.textRating?.value ?? '',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: 10
                              .h), // Add some spacing between the two containers
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 30.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          color: Colors.grey[100],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'What can be improved?'.tr,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            const ReviewChip(),
                            SizedBox(height: 4.h),
                            const Divider(),
                            SizedBox(height: 4.h),
                            Text(
                              'Write Review'.tr,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            TextFormField(
                              controller: ReviewController.to.catatanReview,
                              keyboardType: TextInputType.multiline,
                              maxLines: 4,
                              style: GoogleFonts.montserrat(
                                // Add the desired TextStyle here
                                fontSize: 14.sp,
                                color: MainColor.black,
                                // You can add more style properties as needed
                              ),
                              decoration: InputDecoration(
                                hintText: 'Write a review here...'
                                    .tr, // Add your hint text here
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                SizedBox(
                                  width: 280.0,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      ReviewController.to.addReview();
                                      Get.back();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: MainColor.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                      ),
                                    ),
                                    child: Text(
                                      "Send Review".tr,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 16.sp,
                                          color: MainColor.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () async {
                                    ReviewController.to.pickFile();
                                  },
                                  borderRadius: BorderRadius.circular(30.r),
                                  child: Container(
                                    padding: EdgeInsets.all(8.w),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: MainColor.white,
                                    ),
                                    child: ReviewController
                                                .to.base64File?.value ==
                                            ''
                                        ? Icon(
                                            Icons.add_photo_alternate_outlined,
                                            color: MainColor.primary,
                                            size: 24.sp,
                                          )
                                        : Icon(
                                            Icons.check_circle,
                                            color: MainColor.primary,
                                            size: 24.sp,
                                          ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
