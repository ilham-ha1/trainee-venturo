import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/pages/main_page.dart';
import 'package:trainee/configs/routes/main_route.dart';

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
      body: RefreshIndicator(
        onRefresh: OrderController.to.getOrderHistories,
        child: Obx(
          () => ConditionalSwitch.single(
            context: context,
            valueBuilder: (context) =>
                OrderController.to.orderHistoryState.value,
            caseBuilders: {},
            fallbackBuilder: (context) => CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
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
                            selectedDate:
                                OrderController.to.selectedDateRange.value,
                            onChanged: (value) =>
                                OrderController.to.setDateFilter(range: value),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Conditional.single(
                  context: context,
                  conditionBuilder: (context) =>
                      OrderController.to.filteredHistoryOrder.isNotEmpty,
                  widgetBuilder: (context) => SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: EdgeInsets.only(bottom: 16.r),
                          child: OrderItemCard(
                            order:
                                OrderController.to.filteredHistoryOrder[index],
                            onOrderAgain: () {},
                            onTap: () {
                              Get.put(MainPage.orderBinding);
                              Get.toNamed(
                                '${MainRoute.order}/${OrderController.to.filteredHistoryOrder[index].idOrder}',
                              );
                            },
                          ),
                        ),
                        childCount:
                            OrderController.to.filteredHistoryOrder.length,
                      ),
                    ),
                  ),
                  fallbackBuilder: (context) => const SliverToBoxAdapter(
                    child: SizedBox(),
                  ),
                )
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
              'Total pesanan'.tr,
              style: Get.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            5.horizontalSpace,
            Obx(() => Text(
                  'Rp ${OrderController.to.totalHistoryOrder}',
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
