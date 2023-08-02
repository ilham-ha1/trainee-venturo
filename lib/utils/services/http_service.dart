import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:trainee/modules/global_models/detail_menu_response.dart';
import 'package:trainee/modules/global_models/login_response.dart';
import 'package:trainee/modules/global_models/menu_response.dart';
import 'package:trainee/modules/global_models/order_body.dart';
import 'package:trainee/modules/global_models/order_response.dart';
import 'package:trainee/modules/global_models/promo_response.dart';
import 'package:trainee/modules/global_models/user_discount_response.dart';
import 'package:trainee/modules/global_models/user_order_cancel_response.dart';
import 'package:trainee/modules/global_models/user_order_detail_response.dart';
import 'package:trainee/modules/global_models/user_order_history_response.dart';
import 'package:trainee/modules/global_models/user_order_list_response.dart';
import 'package:trainee/modules/global_models/user_voucher_response.dart';
import 'package:trainee/utils/services/local_storage_service.dart';
import 'package:trainee/modules/global_models/detail_promo_response.dart';

class HttpService extends GetxService {
  HttpService._();

  static final HttpService dioService = HttpService._();

  factory HttpService() {
    return dioService;
  }

  static const Duration timeoutInMiliSeconds = Duration(
    seconds: 20000,
  );

  static Dio dioCall({
    Duration timeout = timeoutInMiliSeconds,
    String? token,
    String? authorization,
  }) {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null) {
      headers['token'] = token;
    }

    if (authorization != null) {
      headers['Authorization'] = authorization;
    }

    var dio = Dio(
      BaseOptions(
        headers: headers,
        baseUrl: GlobalController.to.baseUrl,
        connectTimeout: timeoutInMiliSeconds,
        contentType: "application/json",
        responseType: ResponseType.json,
      ),
    );

    dio.interceptors.add(_authInterceptor());

    return dio;
  }

  static Interceptor _authInterceptor() {
    return QueuedInterceptorsWrapper(
      onRequest: (reqOptions, handler) {
        log('${reqOptions.uri}', name: 'REQUEST URL');
        log('${reqOptions.headers}', name: 'HEADER');

        return handler.next(reqOptions);
      },
      onError: (error, handler) async {
        log(error.message.toString(), name: 'ERROR MESSAGE');
        log('${error.response}', name: 'RESPONSE');

        return handler.next(error);
      },
      onResponse: (response, handler) async {
        log('${response.data}', name: 'RESPONSE');

        return handler.resolve(response);
      },
    );
  }

  static const String baseUrl = 'https://trainee.landa.id/javacode';

  Future<LoginResponse?> login(String email, String password) async {
    const url = '$baseUrl/auth/login';

    try {
      final response = await dioCall().post(
        url,
        data: {
          'email': email,
          'password': password,
        },
      );
      return LoginResponse.fromJson(response.data);
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<LoginResponse?> loginWithGmail(String email, String nama) async {
    const url = '$baseUrl/auth/login';

    try {
      final response = await dioCall().post(
        url,
        data: {
          'is_google': "1",
          'email': email,
          'nama': nama,
        },
      );
      Get.offAndToNamed(MainRoute.getLocation);
      return LoginResponse.fromJson(response.data);
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<MenuResponse?> getAllMenu() async {
    const url = '$baseUrl/menu/all';
    final authToken = LocalStorageService.getToken();

    try {
      final response = await dioCall().get(
        url,
        options: Options(
          headers: {'token': '$authToken'},
        ),
      );
      return MenuResponse.fromJson(response.data);
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<MenuResponse?> getMenuByCategory(String kategori) async {
    final url = '$baseUrl/menu/kategori/$kategori';
    final authToken = LocalStorageService.getToken();

    try {
      final response = await dioCall().get(
        url,
        options: Options(
          headers: {'token': '$authToken'},
        ),
      );
      return MenuResponse.fromJson(response.data);
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<DetailMenuResponse?> getDetailMenu(int id) async {
    final url = '$baseUrl/menu/detail/$id';
    final authToken = LocalStorageService.getToken();

    try {
      final response = await dioCall().get(
        url,
        options: Options(
          headers: {'token': '$authToken'},
        ),
      );
      final DetailMenuResponse detailMenu =
          DetailMenuResponse.fromJson(response.data);
      return detailMenu;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<PromoResponse?> getAllUserPromo() async {
    const url = '$baseUrl/promo/all';
    final authToken = LocalStorageService.getToken();

    try {
      final promoResponse = await dioCall().get(
        url,
        options: Options(
          headers: {'token': '$authToken'},
        ),
      );
      return PromoResponse.fromJson(promoResponse.data);
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<DetailPromoResponse?> getDetailUserPromo(int idPromo) async {
    final url = '$baseUrl/promo/detail/$idPromo';
    final authToken = LocalStorageService.getToken();

    try {
      final response = await dioCall().get(
        url,
        options: Options(
          headers: {'token': '$authToken'},
        ),
      );
      return DetailPromoResponse.fromJson(response.data);
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<DiscountResponse?> getUserDiscount() async {
    final idUser = LocalStorageService.getId();
    final url = '$baseUrl/diskon/user/$idUser';
    final authToken = LocalStorageService.getToken();

    try {
      final response = await dioCall().get(
        url,
        options: Options(
          headers: {'token': '$authToken'},
        ),
      );
      return DiscountResponse.fromJson(response.data);
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<VoucherResponse?> getUserVoucher() async {
    final idUser = LocalStorageService.getId();
    final url = '$baseUrl/voucher/user/$idUser';
    final authToken = LocalStorageService.getToken();

    try {
      final response = await dioCall().get(
        url,
        options: Options(
          headers: {'token': '$authToken'},
        ),
      );
      return VoucherResponse.fromJson(response.data);
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<OrderResponse?> postOrder(Order orderData, List<Menu> menuData) async {
    const url = '$baseUrl/order/add';
    final authToken = LocalStorageService.getToken();

    final orderBody = orderData;
    final listMenuBody = menuData;
    try {
      final response = await dioCall().post(
        url,
        data: OrderBody(
          order: orderBody,
          menu: listMenuBody
        ),
        options: Options(
          headers: {
            'token': '$authToken',
            'Content-Type': 'application/json',
          },
        ),
      );
      return OrderResponse.fromJson(response.data);
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<UserOrderListResponse?> getUserOrderList() async{
    final idUser = LocalStorageService.getId();
    final url = '$baseUrl/order/user/$idUser';
    final authToken = LocalStorageService.getToken();

    try {
      final response = await dioCall().get(
        url,
        options: Options(
          headers: {'token': '$authToken'},
        ),
      );
      return UserOrderListResponse.fromJson(response.data);
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<UserOrderHistoryResponse?> getUserOrderHistory() async{
    final idUser = LocalStorageService.getId();
    final url = '$baseUrl/order/history/$idUser';
    final authToken = LocalStorageService.getToken();

    try {
      final response = await dioCall().get(
        url,
        options: Options(
          headers: {'token': '$authToken'},
        ),
      );
      return UserOrderHistoryResponse.fromJson(response.data);
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<UserOrderDetailResponse?> getUserOrderDetail(int idOrder) async{
    final url = '$baseUrl/order/detail/$idOrder';
    final authToken = LocalStorageService.getToken();

    try {
      final response = await dioCall().get(
        url,
        options: Options(
          headers: {'token': '$authToken'},
        ),
      );
      return UserOrderDetailResponse.fromJson(response.data);
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<UserOrderCancelResponse?> postCancelOrder(int idOrder) async {
    final url = '$baseUrl/order/batal/$idOrder';
    final authToken = LocalStorageService.getToken();

    try {
      final response = await dioCall().post(
        url,
        options: Options(
          headers: {
            'id_order': idOrder,
            'token': '$authToken',
          },
        ),
      );
      return UserOrderCancelResponse.fromJson(response.data);
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
  }
}
