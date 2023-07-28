import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class QuantityCounter extends StatelessWidget {
  final int quantity;
  final void Function()? onIncrement;
  final void Function()? onDecrement;

  const QuantityCounter({
    Key? key,
    required this.quantity,
    this.onIncrement,
    this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // subtract button
        if (quantity > 0)
          Visibility(
            visible: onDecrement != null,
            maintainState: true,
            maintainAnimation: true,
            maintainSize: true,
            child: Material(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(4),
              child: InkWell(
                onTap: onDecrement,
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 2.r),
                  ),
                  child: Icon(
                    Icons.remove,
                    size: 20.r,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),

        // quantity
        if (quantity > 0)
          Container(
            constraints: BoxConstraints(minWidth: 30.r),
            padding: EdgeInsets.symmetric(horizontal: 10.r),
            child: Text(
              quantity.toString(),
              style: Get.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

        // add button
        Visibility(
          visible: onIncrement != null,
          maintainState: true,
          maintainAnimation: true,
          maintainSize: true,
          child: Material(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(4),
            child: InkWell(
              onTap: onIncrement,
              child: Ink(
                padding: EdgeInsets.all(2.r),
                color: Theme.of(context).primaryColor,
                child: Icon(Icons.add, size: 20.r, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}