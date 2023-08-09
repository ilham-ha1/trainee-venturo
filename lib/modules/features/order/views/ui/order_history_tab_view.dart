import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trainee/configs/pages/main_page.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/modules/global_models/cart.dart';

import '../../controllers/order_controller.dart';
import '../components/date_picker.dart';
import '../components/dropdown_status.dart';
import '../components/order_item_card.dart';

class OrderHistoryTabView extends StatelessWidget {
  const OrderHistoryTabView({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Order History Screen',
      screenClassOverride: 'Trainee',
    );

    return Scaffold(
      body: Obx(
        () => SmartRefresher(
          controller: OrderController.to.refreshControllerHistory,
          enablePullDown: true,
          onRefresh: OrderController.to.onRefreshHistory,
          enablePullUp:
              OrderController.to.canLoadMoreHistory.isTrue ? true : false,
          onLoading: OrderController.to.getOrderHistories,
          child: OrderController.to.historyOrders.isNotEmpty
              ? ConditionalSwitch.single(
                  context: context,
                  valueBuilder: (context) =>
                      OrderController.to.orderHistoryState.value,
                  caseBuilders: {},
                  fallbackBuilder: (context) => CustomScrollView(
                    slivers: [
                      //Date
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25.w, vertical: 25.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: DropdownStatus(
                                  items: OrderController.to.dateFilterStatus,
                                  selectedItem:
                                      OrderController.to.selectedCategory.value,
                                  onChanged: (value) => OrderController.to
                                      .setDateFilter(category: value),
                                ),
                              ),
                              22.horizontalSpaceRadius,
                              Expanded(
                                child: DatePicker(
                                  selectedDate: OrderController
                                      .to.selectedDateRange.value,
                                  onChanged: (value) => OrderController.to
                                      .setDateFilter(range: value),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //List
                      Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            OrderController.to.filteredHistoryOrder.isNotEmpty,
                        widgetBuilder: (context) => SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final orderData = OrderController
                                    .to.filteredHistoryOrder[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 16.r),
                                  child: OrderItemCard(
                                    order: orderData,
                                    onOrderAgain: () async {
                                      if (orderData.menu != null) {
                                        for (var menuItem in orderData.menu!) {
                                          List<int> toppingList = [];

                                          if (menuItem.topping != null &&
                                              menuItem.topping!.isNotEmpty) {
                                            toppingList = menuItem.topping!
                                                .split(',')
                                                .map((topping) =>
                                                    int.tryParse(topping))
                                                .where((topping) =>
                                                    topping !=
                                                    null) // Filter out null values
                                                .map((topping) =>
                                                    topping!) // Convert int? to int
                                                .toList();
                                          }
                                          await OrderController.to
                                              .saveToCart(Cart(
                                            id: menuItem.idMenu, //required
                                            harga: int.parse(
                                                menuItem.harga!), //required
                                            level: null,
                                            catatan: menuItem.catatan == ""
                                                ? ""
                                                : menuItem.catatan,
                                            deskripsi: null, //required
                                            foto: menuItem.foto, //req
                                            topping: toppingList,
                                            jumlah: menuItem.jumlah, //req
                                            nama: menuItem.nama,
                                            kategori: menuItem.kategori,
                                            toppingPrice: null,
                                            levelPrice: null,
                                          ));
                                        }
                                      }
                                      Get.toNamed(MainRoute.checkout);
                                    },
                                    onGiveReview: (index) {
                                      Get.toNamed(MainRoute.review);
                                    },
                                    onTap: () {
                                      Get.put(MainPage.orderBinding);
                                      Get.toNamed(
                                        '${MainRoute.order}/${OrderController.to.filteredHistoryOrder[index].idOrder}',
                                      );
                                    },
                                  ),
                                );
                              },
                              childCount: OrderController
                                  .to.filteredHistoryOrder.length,
                            ),
                          ),
                        ),
                        fallbackBuilder: (context) => const SliverToBoxAdapter(
                          child: SizedBox(),
                        ),
                      )
                    ],
                  ),
                )
              : Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(ImageConstant.bg), // Background Image
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(ImageConstant.icOrderPage),
                          Flexible(
                            child: Text(
                             'Start making an Order. The food you ordered will appear here so you can find your favorites again!'.tr,
                              style: GoogleFonts.montserrat(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.center, // Center the text
                            ),
                          )
                        ],
                      ), // Centered Image
                    ],
                  ),
                ),
        ),
      ),
      bottomNavigationBar: Container(
        width: 1.sw,
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 15.h),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30.r),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Order'.tr,
              style: Get.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            5.horizontalSpace,
            Obx(() => Text(
                  'Rp ${NumberFormat('#,##0', 'id_ID').format(int.parse(OrderController.to.totalHistoryOrder))}',
                  style: Get.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
