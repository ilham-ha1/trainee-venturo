import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/global_models/user_all_review_response.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class ReviewItemCard extends StatelessWidget {
  const ReviewItemCard({
    super.key,
    required this.review,
    this.onTap,
  });

  final Review review;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Ink(
          padding: EdgeInsets.all(7.r),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 8,
                spreadRadius: -1,
                color: Colors.black87,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.date_range_outlined,
                          color: MainColor.primary,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          review.type ?? '',
                          style: GoogleTextStyle.fw600
                              .copyWith(color: MainColor.primary),
                        ),
                        //star place
                        SizedBox(width: 2.w),
                        RatingBar.builder(
                          initialRating: review.score ?? 0, // Set the initial rating value from your data
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize:
                              24.0, // Adjust the size of the rating icons as needed
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                          updateOnDrag: false,
                          onRatingUpdate: (rating) {},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      review.review ?? '',
                      style: GoogleTextStyle.fw400
                          .copyWith(color: MainColor.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                SizedBox(
                  width: 5.w,
                ),
                const Icon(
                  Icons.reply,
                  color: Colors.green,
                )
              ],
            ),
          )),
    );
  }
}
