import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trainee/modules/global_models/login_response.dart';
import 'package:trainee/modules/global_models/cart.dart';

class LocalStorageService extends GetxService {
  LocalStorageService._();
  static final box = Hive.box("Venturo");
  static final boxCart = Hive.box("itemCartMenus");

  static const String _isLoggedInKey = 'isLogin';

  /// Kode untuk setting localstorage sesuai dengan repository
  static Future<void> setAuth(Data serverSelected) async {
    await box.put("id", serverSelected.user.idUser);
    await box.put("name", serverSelected.user.nama);
    await box.put("photo", serverSelected.user.foto);
    await box.put("roles", serverSelected.user.roles);
    await box.put("token", serverSelected.token);
    await box.put(_isLoggedInKey, true);

    /// Log id user
    await FirebaseAnalytics.instance.setUserId(
      id: serverSelected.user.idUser.toString(),
    );
  }

  //mendapatkan token
  static dynamic getToken() {
    return box.get("token");
  }

  //mendapatkan id user
  static dynamic getId() {
    return box.get("id");
  }

  //mendapatkan status login
  static bool isLoggedIn() {
    return box.get(_isLoggedInKey, defaultValue: false) ?? false;
  }

  //menghapus auth
  static Future deleteAuth() async {
    if (box.get("isRememberMe") == false) {
      box.clear();
      box.put("isLogin", false);
    } else {
      box.put("isLogin", false);
    }
  }

   static Future<List<Cart>> getAllCarts() async {
    List<Cart> cartList = boxCart.values.map((dynamic item) => item as Cart).toList();
    return cartList;
  }

  //menyimpan data menu di cart
  static Future<void> saveCart(Cart dataToCart) async {
    await boxCart.put(dataToCart.id,
        dataToCart); // Gunakan kunci yang berbeda untuk data cart
  }

  static Future<void> deleteItemOnCart(int id) async {
    boxCart.delete(id);
  }
}
