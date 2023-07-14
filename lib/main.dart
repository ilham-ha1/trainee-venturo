import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/pages/main_page.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// void main() async{
//    WidgetsFlutterBinding.ensureInitialized();
//    await Firebase.initializeApp(
//      options: DefaultFirebaseOptions.currentPlatform,
//    );

//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://67235a5ef8b341fe85cfc166ab3e917f@o4505525339684864.ingest.sentry.io/4505525351809024';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(MyApp()),
  );
// or define SENTRY_DSN via Dart environment variable (--dart-define)
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Trainee Sekeleton',
          debugShowCheckedModeBanner: false,
          initialRoute: MainRoute.splashScreen,
          theme: mainTheme,
          defaultTransition: Transition.native,
          getPages: MainPage.main,
        );
      },
    );
  }
}
