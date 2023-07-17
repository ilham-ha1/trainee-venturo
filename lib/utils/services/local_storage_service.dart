import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trainee/modules/global_models/global_model.dart';

class LocalStorageService extends GetxService {
  LocalStorageService._();
  static final box = Hive.box("venturo");
  static const String _isLoggedInKey = 'isLogin';

  /// Kode untuk setting localstorage sesuai dengan repository
  static Future<void> setAuth(Data serverSelected) async {
    await box.put("id", serverSelected.user!.id);
    await box.put("name", serverSelected.user!.nama);
    await box.put("photo", serverSelected.user!.humanisFoto);
    await box.put("roles", serverSelected.user!.jabatan);
    await box.put(_isLoggedInKey, true);

    /// Log id user
    await FirebaseAnalytics.instance.setUserId(
      id: serverSelected.user!.id.toString(),
    );
  } 
  //
  //untuk login dengan admin@gmail

  static bool isLoggedIn() {
    return box.get(_isLoggedInKey, defaultValue: false) ?? false;
  }

  static Future deleteAuth() async {
    if (box.get("isRememberMe") == false) {
      box.clear();
      box.put("isLogin", false);
    } else {
      box.put("isLogin", false);
    }
  }



  
}