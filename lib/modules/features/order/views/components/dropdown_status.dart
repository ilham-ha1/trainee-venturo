import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class DropdownStatus extends StatelessWidget {
  final Map<String, String> items;
  final String selectedItem;
  final void Function(String?)? onChanged;

  const DropdownStatus({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(30.r),
      child: DropdownButtonFormField2(
        isDense: true,
        isExpanded: true,
        value: selectedItem,
        style: Get.textTheme.titleSmall,
        iconStyleData: const IconStyleData(
          iconEnabledColor: Colors.black87,
        ),
        buttonStyleData: ButtonStyleData(
            height: 37.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
            )),
        dropdownStyleData: DropdownStyleData(
            offset: Offset(0.h, -8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
            )),
        menuItemStyleData: MenuItemStyleData(
          padding: EdgeInsets.only(left: 15.w),
        ),
        selectedItemBuilder: (context) => items.entries
            .map<Widget>(
              (entry) => Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                alignment: Alignment.centerLeft,
                child: Text(
                  entry.value,
                  style: Get.textTheme.titleSmall,
                ),
              ),
            )
            .toList(),
        alignment: Alignment.bottomCenter,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 4.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1.w),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1.w),
          ),
        ),
        items: items.entries.map<DropdownMenuItem<String>>((entry) {
          return DropdownMenuItem<String>(
            value: entry.key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  entry.value,
                  style: Get.textTheme.titleSmall?.copyWith(
                    color: selectedItem == entry.key
                        ? Theme.of(context).primaryColor
                        : Colors.black38,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}