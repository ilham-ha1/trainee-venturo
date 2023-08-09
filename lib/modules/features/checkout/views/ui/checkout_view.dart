import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:trainee/configs/pages/main_page.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/checkout/views/componenst/cart_list_sliver.dart';
import 'package:trainee/modules/features/checkout/views/componenst/cart_order_bottom_bar.dart';
import 'package:trainee/modules/features/checkout/views/componenst/rounded_app_bar.dart';
import 'package:trainee/modules/features/checkout/views/componenst/tile_option.dart';
import 'package:trainee/modules/features/list/views/components/section_header.dart';

import '../../controllers/checkout_controller.dart';

class CheckoutView extends StatelessWidget{
  const CheckoutView({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  
  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Checkout Screen',
      screenClassOverride: 'Trainee',
    );

    return Scaffold(
      appBar: RoundedAppBar(
        title: 'Pesanan'.tr,
        icon: Icons.shopping_cart_checkout,
         titleStyle: GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      body: Obx(() => CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: 28.verticalSpace),
              if (CheckoutController.to.foodItems.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: SectionHeader(
                    icon: Icons.food_bank_outlined,
                    title: 'Food'.tr,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SliverPadding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
                  sliver: CartListSliver(
                    carts: CheckoutController.to.foodItems,
                  ),
                )
              ],
              SliverToBoxAdapter(child: 17.verticalSpace),
              if (CheckoutController.to.drinkItems.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: SectionHeader(
                    icon: Icons.local_drink_outlined,
                    title: 'Minuman'.tr,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SliverPadding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
                  sliver: CartListSliver(
                    carts: CheckoutController.to.drinkItems,
                  ),
                )
              ],
            ],
          )),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 22.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Total order tile
                    TileOption(
                      title: 'Total Order'.tr,
                      subtitle: '(${CheckoutController.to.cart.length} Menu):',
                      message:
                          'Rp ${NumberFormat('#,##0', 'id_ID').format(CheckoutController.to.totalPrice) }',
                      titleStyle: Get.textTheme.bodyLarge,
                      messageStyle: Get.textTheme.labelLarge!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                    Divider(color: Colors.black54, height: 2.h),

                    // Discount tile
                    if(CheckoutController.to.isVoucherSelected.isFalse)
                      TileOption(
                        icon: Icons.discount_outlined,
                        iconSize: 24.r,
                        title: '${'Discount'.tr} ${CheckoutController.to.totalDiscount}%',
                        message: 'Rp ${NumberFormat('#,##0', 'id_ID').format(CheckoutController.to.discountPrice) }',
                        titleStyle: Get.textTheme.bodyLarge,
                        messageStyle: Get.textTheme.labelLarge!
                            .copyWith(color: Theme.of(context).colorScheme.error),
                        onTap: () {
                          CheckoutController.to.showDiscountDialog();
                        },
                      ),
                    if(CheckoutController.to.isVoucherSelected.isFalse)
                      Divider(color: Colors.black54, height: 2.h),
                    
                    TileOption(
                      icon: Icons.card_giftcard,
                      iconSize: 24.r,
                      title: 'Voucher',
                      message: CheckoutController.to.totalVoucher.toInt() == 0 ? 'Pilih Voucher': 'Rp ${NumberFormat('#,##0', 'id_ID').format(CheckoutController.to.totalVoucher)}',
                      messageSubtitle: CheckoutController.to.totalVoucher.toInt() == 0 ? null : '${CheckoutController.to.voucherName}',
                      titleStyle: Get.textTheme.bodyLarge,
                      messageStyle: CheckoutController.to.totalVoucher.toInt() == 0 ? Get.textTheme.labelLarge!
                          .copyWith(color: MainColor.black): Get.textTheme.labelLarge!
                          .copyWith(color: Theme.of(context).colorScheme.error),
                      onTap: () {
                        Get.put(MainPage.checkoutBinding);
                        Get.toNamed(MainRoute.voucher);
                      },
                    ),

                    Divider(color: Colors.black54, height: 2.h),
                    // Payment options tile
                    TileOption(
                      icon: Icons.payment_outlined,
                      iconSize: 24.r,
                      title: 'Payment'.tr,
                      message: 'Pay Later'.tr,
                      titleStyle: Get.textTheme.bodyLarge,
                      messageStyle: Get.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              CartOrderBottomBar(
                totalPrice: 'Rp ${NumberFormat('#,##0', 'id_ID').format(CheckoutController.to.grandTotalPrice)}',
                onOrderButtonPressed: CheckoutController.to.verify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
