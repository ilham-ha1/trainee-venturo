import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';

class AppBarMenu extends StatelessWidget implements PreferredSizeWidget{
  const AppBarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 68.h,
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
            blurRadius: 18,
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
            padding: const EdgeInsets.only(right: 35.0),
            child: Text(
              "Detail Menu",
              style: TextStyle(
                fontSize: 20.sp,
                color: MainColor.black,
              ),
              textAlign: TextAlign.center,
            ),
          )),
        ],
      ),
    );
  }
  
  @override
    Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
