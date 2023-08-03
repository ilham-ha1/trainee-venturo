import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/order/controllers/detail_order_controller.dart';

import 'checked_step.dart';
import 'unchecked_step.dart';

class OrderTracker extends StatelessWidget {
  const OrderTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pesanan kamu sedang disiapkan'.tr,
          style: GoogleFonts.montserrat(
                             color: MainColor.black, fontWeight: FontWeight.bold, fontSize: 16.sp
                            ),
          textAlign: TextAlign.left,
        ),
        18.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(flex: 10),
            Expanded(
              flex: 10,
              child: Conditional.single(
                context: context,
                conditionBuilder: (context) =>
                    DetailOrderController.to.order.value?.order?.status == 0 ||
                    DetailOrderController.to.order.value?.order?.status == 1,
                widgetBuilder: (context) => const CheckedStep(),
                fallbackBuilder: (context) => const UncheckedStep(),
              ),
            ),
            const Spacer(flex: 3),
            Expanded(
              flex: 42,
              child: Container(
                height: 4.r,
                color: Colors.black,
              ),
            ),
            const Spacer(flex: 3),
            Expanded(
              flex: 10,
              child: Conditional.single(
                context: context,
                conditionBuilder: (context) =>
                    DetailOrderController.to.order.value?.order?.status == 2,
                widgetBuilder: (context) => const CheckedStep(),
                fallbackBuilder: (context) => const UncheckedStep(),
              ),
            ),
            const Spacer(flex: 3),
            Expanded(
              flex: 42,
              child: Container(
                height: 4.r,
                color: Colors.black,
              ),
            ),
            const Spacer(flex: 3),
            Expanded(
              flex: 10,
              child: Conditional.single(
                context: context,
                conditionBuilder: (context) =>
                    DetailOrderController.to.order.value?.order?.status == 3,
                widgetBuilder: (context) => const CheckedStep(),
                fallbackBuilder: (context) => const UncheckedStep(),
              ),
            ),
            const Spacer(flex: 10),
          ],
        ),
        11.verticalSpacingRadius,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Pesanan diterima'.tr,
                style: GoogleFonts.montserrat(
                             color: MainColor.black, fontWeight: FontWeight.normal, fontSize: 11.sp
                            ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            Expanded(
              child: Text(
                'Silahkan Diambil'.tr,
                style: GoogleFonts.montserrat(
                             color: MainColor.black, fontWeight: FontWeight.normal, fontSize: 11.sp
                            ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            Expanded(
              child: Text(
                'Pesanan Selesai'.tr,
                style:GoogleFonts.montserrat(
                             color: MainColor.black, fontWeight: FontWeight.normal, fontSize: 11.sp
                            ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}