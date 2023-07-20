import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/configs/themes/main_color.dart';
class BottomNavigation extends StatelessWidget implements PreferredSizeWidget{
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
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
              const Icon(
                Icons.home,
                size: 34,
                color: MainColor.white,
              ),
              Text(
                "Home",
                style: TextStyle(
                  color: MainColor.white,
                  fontSize: 12.sp,
                )
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.food_bank_rounded,
                size: 34,
                color: MainColor.white,
              ),
              Text(
                "Pesanan",
                style: TextStyle(
                  color: MainColor.white,
                  fontSize: 12.sp,
                )
              ),
            ],
          ),
           Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.account_circle_outlined,
                size: 34,
                color: MainColor.white,
              ),
              Text(
                "Profil",
                style: TextStyle(
                  color: MainColor.white,
                  fontSize: 12.sp,
                )
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