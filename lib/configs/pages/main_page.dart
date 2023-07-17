import 'package:get/route_manager.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/counter/binddings/conter_bindding.dart';
import 'package:trainee/modules/features/counter/views/ui/conter_view.dart';
import 'package:trainee/modules/features/no_connection/view/ui/no_connection_view.dart';
import 'package:trainee/modules/features/splash/binddings/splash_binding.dart';
import 'package:trainee/modules/features/splash/views/ui/splash_view.dart';
import 'package:trainee/modules/features/sign_in/binddings/sing_in_binding.dart';
import 'package:trainee/modules/features/sign_in/views/ui/sign_in_view.dart';

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
  ];
}
