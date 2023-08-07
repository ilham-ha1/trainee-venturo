import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/checkout/views/ui/checkout_view.dart';
import 'package:trainee/modules/features/counter/views/ui/conter_view.dart';
import 'package:trainee/modules/features/list/views/ui/list_item_view.dart';
import 'package:trainee/modules/features/menu/views/ui/menu_view.dart';
import 'package:trainee/modules/features/order/views/ui/order_view.dart';
import 'package:trainee/modules/features/promo/views/ui/promo_view.dart';
import 'package:trainee/modules/features/review/views/ui/review_view.dart';
import 'package:trainee/modules/global_controllers/navigation_controller.dart';
import 'package:trainee/shared/customs/bottom_navigation_custom.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Obx(() => IndexedStack(
          index: NavigationController.to.tabIndex.value,
          children: const [
            ListItemView(),
            OrderView(),
            //  ProfileView(),
          ],
        )),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}
