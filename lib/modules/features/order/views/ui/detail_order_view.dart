import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/checkout/views/componenst/rounded_app_bar.dart';
import 'package:trainee/modules/features/checkout/views/componenst/tile_option.dart';
import 'package:trainee/modules/features/list/views/components/section_header.dart';
import 'package:trainee/modules/features/order/controllers/detail_order_controller.dart';
import 'package:trainee/shared/customs/bottom_navigation_custom.dart';

import '../components/order_list_sliver.dart';
import '../components/order_tracker.dart';

class DetailOrderView extends StatelessWidget {
  const DetailOrderView({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Detail Order Screen',
      screenClassOverride: 'Trainee',
    );

    return Scaffold(
      appBar: RoundedAppBar(
        title: 'Pesanan',
        icon: Icons.shopping_bag_outlined,
        titleStyle: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold, color: MainColor.black),
        actions: [
          Obx(
            () => Conditional.single(
              context: context,
              conditionBuilder: (context) =>
                  DetailOrderController.to.order.value?.order?.status == 0,
              widgetBuilder: (context) => Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
                child: TextButton(
                  onPressed: () {
                    DetailOrderController.to.cancelOrder();
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                  child: Text(
                    'Batalkan'.tr,
                    style: Get.textTheme.labelLarge
                        ?.copyWith(color: const Color(0xFFD81D1D)),
                  ),
                ),
              ),
              fallbackBuilder: (context) => const SizedBox(),
            ),
          ),
        ],
      ),
      body: Obx(
        () => ConditionalSwitch.single(
          context: context,
          valueBuilder: (context) =>
              DetailOrderController.to.orderDetailState.value,
          caseBuilders: {},
          fallbackBuilder: (context) => CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: 28.verticalSpace),
              if (DetailOrderController.to.foodItems.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: SectionHeader(
                    icon: Icons.food_bank_outlined,
                    title: 'Makanan',
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SliverPadding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
                  sliver: OrderListSliver(
                    orders: DetailOrderController.to.foodItems,
                  ),
                )
              ],
              SliverToBoxAdapter(child: 17.verticalSpace),
              if (DetailOrderController.to.drinkItems.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: SectionHeader(
                    icon: Icons.food_bank_outlined,
                    title: 'Minuman',
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SliverPadding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
                  sliver: OrderListSliver(
                    orders: DetailOrderController.to.drinkItems,
                  ),
                )
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => Conditional.single(
              context: context,
              conditionBuilder: (context) =>
                  DetailOrderController.to.orderDetailState.value == 'success',
              widgetBuilder: (context) => Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.r),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 25.h, horizontal: 22.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Total order tile
                          TileOption(
                            title: 'Total Pesanan',
                            subtitle:
                                '(${DetailOrderController.to.order.value?.detail?.length} Menu):',
                            message:
                                'Rp ${NumberFormat('#,##0', 'id_ID').format(DetailOrderController.to.order.value?.order?.totalBayar ?? '0')}',
                            titleStyle: GoogleFonts.montserrat(
                             color: MainColor.black, fontWeight: FontWeight.bold, fontSize: 17.sp
                            ),
                            subtitleStyle: GoogleFonts.montserrat(
                             color: MainColor.black, fontWeight: FontWeight.bold, fontSize: 17.sp
                            ),
                            messageStyle: GoogleFonts.montserrat(
                             color: MainColor.primary, fontWeight: FontWeight.normal, fontSize: 17.sp
                            ),
                          ),
                          Divider(color: Colors.black45, height: 2.h),

                          // Discount tile
                          Conditional.single(
                            context: context,
                            conditionBuilder: (context) =>
                                DetailOrderController
                                        .to.order.value?.order?.diskon ==
                                    1 &&
                                (DetailOrderController
                                            .to.order.value?.order?.potongan ??
                                        0) >
                                    0,
                            widgetBuilder: (context) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TileOption(
                                  icon: Icons.discount_outlined,
                                  iconSize: 24.r,
                                  title: 'Discount',
                                  message:
                                      'Rp ${NumberFormat('#,##0', 'id_ID').format(DetailOrderController.to.order.value?.order?.potongan ?? '0')}',
                                  titleStyle:GoogleFonts.montserrat(
                             color: MainColor.black, fontWeight: FontWeight.bold, fontSize: 17.sp
                            ),
                                  messageStyle:GoogleFonts.montserrat(
                             color:  const Color(0xFFD81D1D), fontWeight: FontWeight.bold, fontSize: 17.sp
                            ),
                                ),
                                Divider(color: Colors.black54, height: 2.h),
                              ],
                            ),
                            fallbackBuilder: (context) => const SizedBox(),
                          ),
                          

                          // Vouchers tile
                          Conditional.single(
                            context: context,
                            conditionBuilder: (context) =>
                                DetailOrderController
                                    .to.order.value?.order?.idVoucher !=
                                0,
                            widgetBuilder: (context) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TileOption(
                                  icon: Icons.discount,
                                  iconSize: 24.r,
                                  title: 'voucher'.tr,
                                  message:
                                      'Rp ${NumberFormat('#,##0', 'id_ID').format(DetailOrderController.to.order.value?.order?.potongan ?? '0')}',
                                  messageSubtitle: DetailOrderController
                                      .to.order.value?.order?.namaVoucher,
                                  titleStyle: GoogleFonts.montserrat(
                             color: MainColor.black, fontWeight: FontWeight.bold, fontSize: 17.sp
                            ),
                                  messageStyle: GoogleFonts.montserrat(
                             color:  const Color(0xFFD81D1D), fontWeight: FontWeight.bold, fontSize: 17.sp
                            ),
                                ),
                                Divider(color: const Color(0xFFD81D1D), height: 2.h),
                              ],
                            ),
                            fallbackBuilder: (context) => const SizedBox(),
                          ),
                          

                          // Payment options tile
                          TileOption(
                            icon: Icons.payment_outlined,
                            iconSize: 24.r,
                            title: 'Pembayaran'.tr,
                            message: 'Pay Later',
                            titleStyle: GoogleFonts.montserrat(
                             color: MainColor.black, fontWeight: FontWeight.bold, fontSize: 17.sp
                            ),
                            messageStyle: GoogleFonts.montserrat(
                             color: MainColor.black, fontWeight: FontWeight.normal, fontSize: 17.sp
                            ),
                          ),

                          Divider(color: Colors.black54, height: 2.h),

                          // total payment
                          TileOption(
                            iconSize: 24.r,
                            title: 'Total Pembayaran'.tr,
                            message:
                                'Rp ${NumberFormat('#,##0', 'id_ID').format(DetailOrderController.to.order.value?.order?.totalBayar ?? '0')}',
                            titleStyle: GoogleFonts.montserrat(
                             color: MainColor.black, fontWeight: FontWeight.bold, fontSize: 17.sp
                            ),
                            messageStyle: GoogleFonts.montserrat(
                             color: MainColor.primary, fontWeight: FontWeight.normal, fontSize: 17.sp
                            ),
                          ),
                          Divider(color: Colors.black54, height: 2.h),
                          24.verticalSpace,

                          // order status track
                          const OrderTracker(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              fallbackBuilder: (context) => const SizedBox(),
            ),
          ),
          const BottomNavigation(),
        ],
      ),
    );
  }
}
