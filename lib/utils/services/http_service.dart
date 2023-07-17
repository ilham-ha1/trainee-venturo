import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:trainee/modules/global_models/global_model.dart';

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

    // Assuming the response.data is of type Map<String, dynamic>
    return LoginResponse.fromJson(response.data);
  } catch (exception, stackTrace) {
    await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
    );

    // Handle the exception by returning an appropriate LoginResponse with status code and null data or throw an error.
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
    Get.offAndToNamed(MainRoute.initial);
    // Assuming the response.data is of type Map<String, dynamic>
    return LoginResponse.fromJson(response.data);
  } catch (exception, stackTrace) {
    await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
    );

    // Handle the exception by returning an appropriate LoginResponse with status code and null data or throw an error.
    return null;
  }
}

}
