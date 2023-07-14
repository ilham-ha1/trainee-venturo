import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/pages/main_page.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );

  runApp(const MyApp());
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
