import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/localization/localization.dart';
import 'package:trainee/configs/pages/main_page.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trainee/modules/global_binddings/global_binding.dart';
import 'package:trainee/modules/global_models/cart.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:trainee/utils/services/firebase_messaging_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    FirebaseMessagingService().initialize();

    /// Localstorage init
    await Hive.initFlutter();
    Hive.registerAdapter(CartAdapter());
    await Hive.openBox("Venturo");
    await Hive.openBox("itemCartMenus");

    /// Firebase init
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseMessagingService.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // log((await FirebaseMessagingService.instance.getToken()).toString());
    await FirebaseMessaging.instance.subscribeToTopic('order');

    await FirebaseMessagingService().initialize();
    FirebaseMessaging.onBackgroundMessage(
        FirebaseMessagingService.handleBackgroundNotif);

    /// Sentry init
    await SentryFlutter.init(
      (options) {
        options.dsn =
            'https://67235a5ef8b341fe85cfc166ab3e917f@o4505525339684864.ingest.sentry.io/4505525351809024';
        // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
        // We recommend adjusting this value in production.
        options.tracesSampleRate = 1.0;
      },
      appRunner: () => runApp(const MyApp()),
    );
// or define SENTRY_DSN via Dart environment variable (--dart-define)
  } catch (exception, stacktrace) {
    await Sentry.captureException(
      exception,
      stackTrace: stacktrace,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Initial Screen',
      screenClassOverride: 'Trainee',
    );

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
          initialBinding: GlobalBinding(),
          builder: EasyLoading.init(),
          translations: Localization(),
          locale: Localization.defaultLocale,
          fallbackLocale: Localization.fallbackLocale,
          supportedLocales: Localization.locales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}
