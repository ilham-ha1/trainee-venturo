import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trainee/configs/routes/main_route.dart';

import '../../controllers/order_controller.dart';
import '../components/order_item_card.dart';

class OnGoingOrderTabView extends StatelessWidget {
  const OnGoingOrderTabView({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Ongoing Order Screen',
      screenClassOverride: 'Trainee',
    );

    return Obx(
      () => 
        SmartRefresher(
          controller: OrderController.to.refreshControllerOnGoing,
          enablePullDown: true,
          onRefresh: OrderController.to.onRefreshOnGoing,
          enablePullUp:
              OrderController.to.canLoadMoreOnGoing.isTrue ? true : false,
          onLoading: OrderController.to.getOngoingOrders,
          child: ListView.separated(
            padding: EdgeInsets.all(25.r),
            itemBuilder: (context, index) => OrderItemCard(
              order: OrderController.to.onGoingOrders[index],
              onTap: () {
                Get.toNamed(
                  '${MainRoute.order}/${OrderController.to.onGoingOrders[index].idOrder}',
                );
              },
              onOrderAgain: () {},
            ),
            separatorBuilder: (context, index) => 16.verticalSpace,
            itemCount: OrderController.to.onGoingOrders.length,
          )));
  }
}
