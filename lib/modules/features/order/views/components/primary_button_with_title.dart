import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PrimaryButtonWithTitle extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? titleColor;
  final bool isLoading;
  final VisualDensity? visualDensity;
  final bool isCompact;
  final double? width;
  final double? height;

  const PrimaryButtonWithTitle({
    super.key,
    this.onPressed,
    required this.title,
    this.backgroundColor,
    this.borderColor,
    this.titleColor,
    this.width,
    this.height,
    this.isLoading = false,
    this.visualDensity,
  }) : isCompact = false;

  const PrimaryButtonWithTitle.compact({
    Key? key,
    required this.title,
    this.backgroundColor,
    this.borderColor,
    this.titleColor,
    this.onPressed,
    this.width,
    this.height,
    this.isLoading = false,
  })  : visualDensity = VisualDensity.compact,
        isCompact = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColorDark,
        maximumSize: isCompact
            ? Size(width ?? 100.w, height ?? 30.h)
            : Size(
                width ?? 1.sw,
                height ?? 56.h,
              ),
        side: BorderSide(
          color: borderColor ?? Theme.of(context).primaryColorDark,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
        ),
        elevation: 2,
        tapTargetSize: isCompact ? MaterialTapTargetSize.shrinkWrap : null,
        minimumSize: isCompact
            ? Size(width ?? 100.w, height ?? 30.h)
            : Size(
                width ?? 1.sw,
                height ?? 56.h,
              ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isLoading)
            Text(
              title,
              textAlign: TextAlign.center,
              style: Get.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: isCompact ? 10.sp : 14.sp,
                color: titleColor ?? Colors.white,
              ),
            ),
          isLoading ? 15.horizontalSpace : 0.horizontalSpace,
          isLoading
              ? SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.w,
                    color: titleColor ?? Colors.white,
                  ),
                )
              : 0.horizontalSpace,
        ],
      ),
    );
  }
}