import 'package:flutter/material.dart';
import 'package:trainee/modules/features/order/views/ui/ongoing_order_tab.dart';
import 'package:trainee/modules/features/order/views/ui/order_history_tab_view.dart';
import 'package:trainee/shared/customs/bottom_navigation_custom.dart';

import '../components/order_top_bar.dart';


class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: OrderTopBar(),
          body: TabBarView(
            children: [
              OnGoingOrderTabView(),
              OrderHistoryTabView(),
            ],
          ),
          bottomNavigationBar: BottomNavigation(),
        ),
      ),
    );
  }
}