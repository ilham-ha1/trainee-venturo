import 'package:get/route_manager.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/checkout/binddings/checkout_binding.dart';
import 'package:trainee/modules/features/checkout/views/ui/checkout_view.dart';
import 'package:trainee/modules/features/dashboard/binddings/dashboard_binding.dart';
import 'package:trainee/modules/features/dashboard/views/ui/dashboard_view.dart';
import 'package:trainee/modules/features/edit_menu/binddings/edit_menu_binding.dart';
import 'package:trainee/modules/features/edit_menu/views/ui/edit_menu_view.dart';
import 'package:trainee/modules/features/checkout/views/ui/voucher/detail_voucher_view.dart';
import 'package:trainee/modules/features/checkout/views/ui/voucher/voucher_view.dart';
import 'package:trainee/modules/features/order/views/ui/detail_order_view.dart';
import 'package:trainee/modules/features/order/views/ui/order_view.dart';
import 'package:trainee/modules/features/profile/binddings/profile_binding.dart';
import 'package:trainee/modules/features/profile/views/ui/profile_view.dart';
import 'package:trainee/modules/features/promo/binddings/promo_binding.dart';
import 'package:trainee/modules/features/promo/views/ui/promo_view.dart';
import 'package:trainee/modules/features/initial/binddings/initial_binding.dart';
import 'package:trainee/modules/features/initial/views/ui/get_location_screen.dart';
import 'package:trainee/modules/features/list/binddings/list_binding.dart';
import 'package:trainee/modules/features/list/views/ui/list_item_view.dart';
import 'package:trainee/modules/features/menu/binddings/menu_binding.dart';
import 'package:trainee/modules/features/no_connection/view/ui/no_connection_view.dart';
import 'package:trainee/modules/features/review/binddings/review_binding.dart';
import 'package:trainee/modules/features/review/views/ui/review_view.dart';
import 'package:trainee/modules/features/splash/binddings/splash_binding.dart';
import 'package:trainee/modules/features/splash/views/ui/splash_view.dart';
import 'package:trainee/modules/features/sign_in/binddings/sing_in_binding.dart';
import 'package:trainee/modules/features/sign_in/views/ui/sign_in_view.dart';
import 'package:trainee/modules/features/menu/views/ui/menu_view.dart';
import 'package:trainee/modules/features/order/binddings/detail_order_binding.dart';
import 'package:trainee/modules/features/order/binddings/order_binding.dart';

abstract class MainPage {
  static final checkoutBinding = CheckoutBinding();
  static final orderBinding = OrderBinding();
  static final main = [
    /// Setup
    GetPage(
        name: MainRoute.splashScreen,
        page: () => const SplashView(),
        binding: SplashBinding()),
    GetPage(name: MainRoute.noConnection, page: () => const NoConnectionView()),
    GetPage(
      name: MainRoute.signIn,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: MainRoute.getLocation,
      page: () => const GetLocationScreen(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: MainRoute.list,
      page: () => const ListItemView(),
      binding: ListBinding(),
    ),
    GetPage(
      name: MainRoute.menu,
      page: () => const MenuView(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: MainRoute.promo,
      page: () => const PromoView(),
      binding: PromoBinding(),
    ),
    GetPage(
      name: MainRoute.checkout,
      page: () => const CheckoutView(),
      binding: checkoutBinding,
    ),
    GetPage(
        name: MainRoute.voucher,
        page: () => const VoucherView(),
        binding: checkoutBinding
    ),
    GetPage(
      name: MainRoute.detailVoucher,
      page: () => const DetailVoucherView(),
    ),
    GetPage(
      name: MainRoute.editMenu,
      page: () => const EditMenuView(),
      binding: EditMenuBinding(),
    ),
    GetPage(
      name: MainRoute.order,
      page: () => const OrderView(),
      binding: orderBinding,
    ),
    GetPage(
      name: MainRoute.orderDetail,
      page: () => const DetailOrderView(),
      binding: DetailOrderBinding(),
    ),
    GetPage(
      name: MainRoute.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding()
    ),
    GetPage(
      name: MainRoute.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding()
    ),
    GetPage(
      name: MainRoute.review,
      page: () => const ReviewView(),
      binding: ReviewBinding()
    ),
    GetPage(
      name: MainRoute.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding()
    ),
  ];
}
