import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/global_models/cart.dart';

import '../../../list/views/components/menu_card.dart';
import '../../controllers/checkout_controller.dart';

class CartListSliver extends StatelessWidget {
  const CartListSliver({
    super.key,
    required this.carts,
  });

  final List<Cart> carts;

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.5.h),
            child: Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      CheckoutController.to.deleteItem(carts[index].id);
                    },
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(10.r),
                    ),
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: MenuCard(
                menu: carts[index],
                onTap: () {
                  Get.toNamed(MainRoute.menu);
                },
                qty: RxInt(carts[index].jumlah),
                catatan: RxString(carts[index].catatan ?? ''),
                add: () => CheckoutController.to.increaseQty(carts[index]),
                min: () => CheckoutController.to.decreaseQty(carts[index]),
                catatanDetailTextController:
                    CheckoutController.to.catatanDetailTextController,
              ),
            ),
          );
        },
        childCount: carts.length,
      ),
      itemExtent: 112.h,
    );
  }
}
