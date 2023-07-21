import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/promo/controllers/promo_controller.dart';
import 'package:trainee/modules/features/promo/views/components/promo_app_bar.dart';
import 'package:trainee/modules/features/promo/views/components/promo_card.dart';
import 'package:trainee/shared/customs/bottom_navigation_custom.dart';


class PromoView extends StatelessWidget {
  const PromoView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(40, 158, 158, 158),
        appBar: const PromoAppBar(),
        body: Obx(() {
          final detailPromo = PromoController.to.detailPromo.value;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
                  child: PromoCard(
                     id: detailPromo.idPromo ?? 0,
                    enableShadow: false,
                    termCondition: detailPromo.syaratKetentuan,
                    promoName: detailPromo.nama.toString(),
                    discountNominal: detailPromo.nominal ?? 0,
                    voucherNominal: detailPromo.nominal ?? 0,
                    thumbnailUrl: detailPromo.foto ?? "",
                  ),
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
                        Text("Nama Promo",
                            style: TextStyle(
                                 fontWeight: FontWeight.bold, fontSize: 16.sp, color: MainColor.black)),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                              detailPromo.nama ?? '',
                              style: TextStyle(
                                   fontWeight: FontWeight.bold,fontSize: 20.sp, color: MainColor.primary)),
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
                                Text("Syarat Dan Ketentuan",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: MainColor.black)),
                                Text(
                                  detailPromo.syaratKetentuan?.replaceAll('<p>', '').replaceAll('</p>', '') ?? '',
                                  style: TextStyle(fontSize: 16.sp, color: MainColor.black)
                                )
                              ],
                            ))
                          ],
                        )
                      ]),
                ),
              ))
            ],
          );
        }),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}
