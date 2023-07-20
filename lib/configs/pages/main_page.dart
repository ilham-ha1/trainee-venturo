import 'package:get/route_manager.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/counter/binddings/conter_bindding.dart';
import 'package:trainee/modules/features/counter/views/ui/conter_view.dart';
import 'package:trainee/modules/features/discount/views/ui/discount_view.dart';
import 'package:trainee/modules/features/initial/binddings/initial_binding.dart';
import 'package:trainee/modules/features/initial/views/ui/get_location_screen.dart';
import 'package:trainee/modules/features/list/binddings/list_binding.dart';
import 'package:trainee/modules/features/list/views/ui/list_item_view.dart';
import 'package:trainee/modules/features/menu/binddings/menu_binding.dart';
import 'package:trainee/modules/features/no_connection/view/ui/no_connection_view.dart';
import 'package:trainee/modules/features/splash/binddings/splash_binding.dart';
import 'package:trainee/modules/features/splash/views/ui/splash_view.dart';
import 'package:trainee/modules/features/sign_in/binddings/sing_in_binding.dart';
import 'package:trainee/modules/features/sign_in/views/ui/sign_in_view.dart';
import 'package:trainee/modules/features/menu/views/ui/menu_view.dart';

abstract class MainPage {
  static final main = [
    /// Setup
    GetPage(
      name: MainRoute.initial,
      page: () => const ConterView(),
      binding: ConterBindding(),
    ),
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
      page: () => MenuView(idMenu: Get.arguments,),
      binding: MenuBinding(),
    ),
    GetPage(
      name: MainRoute.discount, 
      page: () => const DiscountView(),
    )
  ];
}
