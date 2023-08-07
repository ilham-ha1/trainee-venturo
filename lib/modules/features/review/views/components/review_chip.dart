import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/review/controllers/review_controller.dart';

class ReviewChip extends StatelessWidget {
  const ReviewChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            width: 1.sw,
            height: 60.h,
            child: Obx( () =>
               ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: ReviewController.to.chip.length,
                itemBuilder: ((context, index) {
                  final chip = ReviewController.to.chip[index];
                  return Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          final ReviewController reviewController =
                              ReviewController.to;
                          if (reviewController.selectedChip?.value == chip) {
                            reviewController.selectedChip?.value = '';
                          } else {
                            reviewController.selectedChip?.call(chip);
                          }
                        },
                        borderRadius: BorderRadius.circular(25.r),
                        child: Ink(
                          padding: EdgeInsets.symmetric(horizontal: 10.r),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: MainColor.primary,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(30.r),
                            color: chip ==
                                    ReviewController
                                        .to.selectedChip?.value
                                ? MainColor.primary
                                : MainColor.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    chip,
                                    style: GoogleFonts.montserrat(
                                      color: chip ==
                                              ReviewController
                                        .to.selectedChip?.value
                                          ? MainColor.white
                                          : MainColor.black,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  chip == ReviewController
                                        .to.selectedChip?.value
                                      ? const Padding(
                                          padding: EdgeInsets.only(left: 2.0),
                                          child: Icon(
                                            Icons.check_rounded,
                                            size: 12,
                                            color: MainColor.white,
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ))
      ;
  }
}
