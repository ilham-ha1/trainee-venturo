import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      box.clear();
      box.put(_isLoggedInKey, false);
    } else {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      box.put(_isLoggedInKey, false);
    }
  }

  //mendapatkan semua data cart
  static Future<List<Cart>> getAllCarts() async {
    List<Cart> cartList =
        boxCart.values.map((dynamic item) => item as Cart).toList();
    return cartList;
  }

  //menyimpan data menu di cart
  static Future<void> saveCart(Cart dataToCart) async {
    final key = dataToCart.id;

    if (key is String || key is int) {
      await boxCart.put(key, dataToCart);
      Get.snackbar('Menambahkan Pesanan', 'Berhasil menambahkan Pesanan');
    } else {
      // Handle the case where the key is not a valid type
      Get.snackbar('Menambahkan Pesanan', 'Gagal menambahkan Pesanan');
    }
  }

  //menghapus item di cart
  static Future<void> deleteItemOnCart(int id) async {
    boxCart.delete(id);
  }
}
