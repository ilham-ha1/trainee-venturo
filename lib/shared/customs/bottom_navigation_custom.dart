import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_color.dart';

class BottomNavigation extends StatelessWidget implements PreferredSizeWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    int tabScreen = 0;
    return Container(
      width: double.infinity,
      height: 68.h,
      padding: EdgeInsets.symmetric(
        horizontal: 55.w,
      ),
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                color: MainColor.white,
                onPressed: () {
                  tabScreen = 0;
                  Get.toNamed(MainRoute.list);
                },
                icon: tabScreen == 0
                    ? const Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 34,
                      )
                    : const Icon(
                        Icons.home,
                        color: Color.fromARGB(105, 255, 255, 255),
                        size: 34,
                      ),
              ),
              Text("Beranda",
                  style: TextStyle(
                    color: MainColor.white,
                    fontSize: 12.sp,
                  )),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  color: MainColor.white,
                  onPressed: () {
                    tabScreen = 1;
                    Get.toNamed(MainRoute.order);
                  },
                  icon: tabScreen == 1
                      ? const Icon(
                          Icons.food_bank_rounded,
                          size: 34,
                          color: MainColor.white,
                        )
                      : const Icon(
                          Icons.food_bank_rounded,
                          color: Color.fromARGB(105, 255, 255, 255),
                          size: 34,
                        )),
              Text("Pesanan",
                  style: TextStyle(
                    color: MainColor.white,
                    fontSize: 12.sp,
                  )),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    // tabScreen = 2;
                  },
                  icon: tabScreen == 2
                      ? const Icon(
                          Icons.account_circle_outlined,
                          size: 34,
                          color: MainColor.white,
                        )
                      : const Icon(
                          Icons.account_circle_outlined,
                          color: Color.fromARGB(105, 255, 255, 255),
                          size: 34,
                        )),
              Text("Profil",
                  style: TextStyle(
                    color: MainColor.white,
                    fontSize: 12.sp,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
