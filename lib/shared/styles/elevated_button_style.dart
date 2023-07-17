import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/configs/themes/main_color.dart';

class EvelatedButtonStyle {
  static final mainRounded = ButtonStyle(
    minimumSize: MaterialStateProperty.all<Size>(
      const Size(double.infinity, 50),
    ),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(144.r),
      ),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(
      MainColor.primary,
    ),
    foregroundColor: MaterialStateProperty.all<Color>(
      MainColor.primary,
    ),
    padding: MaterialStateProperty.all<EdgeInsets>(
      EdgeInsets.symmetric(
        vertical: 14.h,
        horizontal: 24.w,
      ),
    ),
  );
  static final googleRounded = ButtonStyle(
    minimumSize: MaterialStateProperty.all<Size>(
      const Size(double.infinity, 50),
    ),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(144.r),
      ),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(
      MainColor.white,
    ),
    foregroundColor: MaterialStateProperty.all<Color>(
      MainColor.white,
    ),
    padding: MaterialStateProperty.all<EdgeInsets>(
      EdgeInsets.symmetric(
        vertical: 14.h,
        horizontal: 24.w,
      ),
    ),
  );
}