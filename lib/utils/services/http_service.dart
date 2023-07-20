import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:trainee/modules/global_models/detail_menu_response.dart';
import 'package:trainee/modules/global_models/login_response.dart';
import 'package:trainee/modules/global_models/menu_response.dart';
import 'package:trainee/modules/global_models/promo_response.dart';
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

  Future<DetailPromo?> getDetailUserPromo(String idPromo) async {
    final url = '$baseUrl/promo/detail/$idPromo';
    final authToken = LocalStorageService.getToken();

    try {
      final response = await dioCall().get(
        url,
        options: Options(
          headers: {'token': '$authToken'},
        ),
      );
      return DetailPromo.fromJson(response.data);
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

  Future<DataDetailMenu?> getDetailMenu(String id) async {
    final url = '$baseUrl/menu/kategori/$id';
    final authToken = LocalStorageService.getToken();

    try {
      final response = await dioCall().get(
        url,
        options: Options(
          headers: {'token': '$authToken'},
        ),
      );
      final Map<String, dynamic> responseData = response.data;
      final DataDetailMenu detailMenu = DataDetailMenu.fromJson(responseData);
      return detailMenu;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
  }


}
