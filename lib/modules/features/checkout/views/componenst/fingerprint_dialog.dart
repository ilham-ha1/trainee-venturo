import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FingerprintDialog extends StatelessWidget {
  const FingerprintDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // title
          Text(
            'Verify Order'.tr,
            style: Get.textTheme.headlineMedium,
          ),

          // subtitle
          Text(
            'Finger Print',
            style: Get.textTheme.bodySmall!.copyWith(color: Colors.black),
          ),
          30.verticalSpacingRadius,
          
          // fingerprint icon
          GestureDetector(
            child: Icon(Icons.fingerprint,
                size: 80.r, color: Theme.of(context).primaryColor),
            onTap: () => Get.back<String>(result: 'fingerprint'),
          ),
          30.verticalSpacingRadius,
          Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: Color.fromARGB(145, 51, 51, 51),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      'or'.tr,
                      style: TextStyle(
                        color: const Color.fromARGB(145, 51, 51, 51),
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: Color.fromARGB(145, 51, 51, 51),
                    ),
                  ),
                ],
              ),
          // verify using pin code
          TextButton(
            onPressed: () => Get.back<String>(result: 'pin'),
            child: Text(
              'Verify Using Pin'.tr,
              style: Get.textTheme.titleSmall!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}