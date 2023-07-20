import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/discount/views/components/promo_card.dart';

class DiscountView extends StatelessWidget {
  const DiscountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.h),
        child: Container(
          width: double.infinity,
          height: 65.h,
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30.r),
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
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back)),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(right: 55.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.discount),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Promo",
                      style: TextStyle(fontSize: 20.sp, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
              child: PromoCard(discountNominal: '20',promoName: 'kerja', thumbnailUrl: 'as',enableShadow: true,),
            ),
          ),
          Expanded(
            child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
              vertical: 25.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30.r),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Promo",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: MainColor.black
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                          "Berhasil mereferensikan rekan/teman untuk menjadi karyawan",
                          style: TextStyle(
                              fontSize: 20.sp, color: MainColor.primary)),
                    ),
                    const Divider(
                      color: Colors.black,
                      height: 1.5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.list,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Syarat Dan Ketentuan",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: MainColor.black
                              )
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. A cras semper auctor neque. Ac turpis egestas integer eget aliquet. Blandit libero volutpat sed cras ornare arcu dui vivamus arcu. Velit ut tortor pretium viverra suspendisse. Quisque egestas diam in arcu cursus euismod. Pharetra vel turpis nunc eget lorem dolor. Gravida neque convallis a cras semper auctor. Magna fringilla urna porttitor rhoncus dolor. Ornare arcu odio ut sem nulla pharetra diam. Augue ut lectus arcu bibendum at varius vel pharetra vel. Tempor id eu nisl nunc mi ipsum faucibus vitae. Mi proin sed libero enim sed faucibus. Tellus orci ac auctor augue mauris augue neque gravida.",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: MainColor.black
                              )
                            )
                          ],
                        ))
                      ],
                    )
                  ]),
            ),
          ))
        ],
      ),
    );
  }
}
