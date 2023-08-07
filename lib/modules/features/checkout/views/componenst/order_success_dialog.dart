import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/modules/global_controllers/navigation_controller.dart';

class OrderSuccessDialog extends StatelessWidget {
  const OrderSuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          28.verticalSpace,
          Image.asset(ImageConstant.orderPrepared),
          28.verticalSpace,
          Text(
            'Pesanan Sedang Disiapkan'.tr,
            style: Get.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          14.verticalSpace,
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: 'Kamu dapat melacak pesnaanmu di fitur',
                style: Get.textTheme.bodySmall!.copyWith(
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: ' ${'Pesanan'}',
                style: Get.textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ]),
            textAlign: TextAlign.center,
          ),
          14.verticalSpace,
          SizedBox(
            width: 168.w,
            child: ElevatedButton(
              onPressed: () {
                Get.back();
                NavigationController.to.changeTabIndex(1);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                maximumSize: Size(
                  1.sw,
                  56.h,
                ),
                side: BorderSide(
                  color: Theme.of(context).primaryColorDark,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.r),
                ),
                elevation: 2,
                tapTargetSize: null,
                minimumSize: Size(
                  1.sw,
                  56.h,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Oke',
                    textAlign: TextAlign.center,
                    style: Get.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
