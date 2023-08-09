import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/checkout/views/componenst/bottom_bar_detail_voucher.dart';
import 'package:trainee/modules/features/checkout/views/componenst/rounded_app_bar.dart';
import 'package:trainee/modules/global_models/user_voucher_response.dart';
import 'package:intl/intl.dart';

class DetailVoucherView extends StatelessWidget {
  const DetailVoucherView({super.key});

  @override
  Widget build(BuildContext context) {
    final Voucher voucher = Get.arguments;
    String dateStart = DateFormat('dd/MM/yyyy').format(
        DateTime.fromMillisecondsSinceEpoch((voucher.periodeMulai!) * 1000));
    String dateEnd = DateFormat('dd/MM/yyyy').format(
        DateTime.fromMillisecondsSinceEpoch((voucher.periodeSelesai!) * 1000));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: RoundedAppBar(
          title: "Detail Voucher".tr,
          titleStyle: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600, color: Colors.black),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
                child: Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(voucher.infoVoucher ??
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
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
                      Text(voucher.nama!,
                          style: GoogleFonts.montserrat(
                              fontSize: 20.sp,
                              color: MainColor.primary,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(voucher.catatan ?? "",
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: MainColor.black,
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      const Divider(
                        color: MainColor.black,
                        height: 1.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 110,
                              child: Text(
                                "Valid Date".tr,
                                style: GoogleFonts.montserrat(
                                    fontSize: 18.sp,
                                    color: MainColor.black,
                                    fontWeight: FontWeight.w800),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            Text('$dateStart - $dateEnd',
                                style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                ))
                          ],
                        ),
                      ),
                      const Divider(
                        color: MainColor.black,
                        height: 1.5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomBarDetailVoucher(voucher: voucher),
      ),
    );
  }
}
