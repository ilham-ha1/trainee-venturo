import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/global_controllers/navigation_controller.dart';

class BottomNavigation extends StatelessWidget implements PreferredSizeWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 55.w),
      decoration: BoxDecoration(
        color: MainColor.black,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                color: MainColor.white,
                onPressed: () {
                  NavigationController.to.tabIndex(0);
                },
                icon: Obx(() => Icon(
                      Icons.home,
                      color: NavigationController.to.tabIndex.value == 0  
                          ? Colors.white
                          : const Color.fromARGB(105, 255, 255, 255),
                      size: 30,
                    )),
              ),
              Text(
                "Home".tr,
                style: TextStyle(
                  color: MainColor.white,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          Column(
             mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                color: MainColor.white,
                onPressed: () {
                  NavigationController.to.tabIndex(1);
                },
                icon: Obx(() => Icon(
                      Icons.food_bank_rounded,
                      size: 30,
                      color: NavigationController.to.tabIndex.value == 1
                          ? MainColor.white
                          : const Color.fromARGB(105, 255, 255, 255),
                    )),
              ),
              Text(
                "Order".tr,
                style: TextStyle(
                  color: MainColor.white,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                   NavigationController.to.tabIndex(2);
                },
                icon: Obx(() => Icon(
                      Icons.account_circle_outlined,
                      size: 30,
                      color: NavigationController.to.tabIndex.value == 2
                          ? MainColor.white
                          : const Color.fromARGB(105, 255, 255, 255),
                    )),
              ),
              Text(
                "Profile".tr,
                style: TextStyle(
                  color: MainColor.white,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
