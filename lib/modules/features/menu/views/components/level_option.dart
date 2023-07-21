import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/menu/controllers/menu_controller.dart';

class LevelOption extends StatelessWidget {
  const LevelOption({super.key});

  @override
  Widget build(BuildContext context) {
    final dataLevel = MenuDetailController.to.level;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Obx(() => InkWell(
            onTap: dataLevel.isNotEmpty ? () => 
            showModalBottomSheet(
              context: context, 
              builder: (context) => 
              Container(
                 width: 1.sw,
                      height: 150,
                      padding: EdgeInsets.symmetric(
                        horizontal: 25.w,
                        vertical: 25.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                  ),
                 
              ): (){},
          )),
    );
  }
}
