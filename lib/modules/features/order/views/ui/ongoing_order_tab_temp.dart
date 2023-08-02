import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/pages/main_page.dart';
import 'package:trainee/configs/routes/main_route.dart';

import '../../controllers/order_controller.dart';
import '../components/order_item_card.dart';

class OnGoingOrderTabViewTemp extends StatelessWidget {
  const OnGoingOrderTabViewTemp({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Ongoing Order Screen',
      screenClassOverride: 'Trainee',
    );

    return RefreshIndicator(
      onRefresh: () async => OrderController.to.getOngoingOrders(),
      child: Obx(
        () => ListView.separated(
          padding: EdgeInsets.all(25.r),
          itemBuilder: (context, index) => OrderItemCard(
            order: OrderController.to.onGoingOrders[index],
            onTap: () {
              Get.put(MainPage.orderBinding);
              Get.toNamed(
                '${MainRoute.order}/${OrderController.to.onGoingOrders[index].idOrder}',
              );
            },
            onOrderAgain: () {
              
            },
          ),
          separatorBuilder: (context, index) => 16.verticalSpace,
          itemCount: OrderController.to.onGoingOrders.length,
        ),
      ),
    );
  }
}
