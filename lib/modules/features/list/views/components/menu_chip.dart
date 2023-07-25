import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';

class MenuChip extends StatelessWidget {
  final bool isSelected;
  final String text;
  final Function()? onTap;

  const MenuChip({
    Key? key,
    this.isSelected = false,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30.r),
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: 14.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: isSelected ? MainColor.black : MainColor.primary,
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 8,
              spreadRadius: -1,
              color: Colors.black54,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Row(
              children:[ 
                if(text.toLowerCase() == 'semua menu')
                  const Icon(Icons.list, color: MainColor.white,)
                else if(text.toLowerCase() == 'makanan')
                  const Icon(Icons.food_bank, color: MainColor.white)
                else
                  const Icon(Icons.local_drink, color: MainColor.white)
                ,
                const SizedBox(width: 8),
                Text(
                  text,
                  style: Get.textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                  ),
                ),
            ]),
          ),
        ),
      ),
    );
  }
}