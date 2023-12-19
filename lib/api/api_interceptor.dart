import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';

import '../routes/app_routes.dart';
import '../shared/widget/error_snackbar.dart';
import '../utils/get_tokens.dart';
import '../utils/shared_preferences_manager.dart';
import 'api_path.dart';

class APIInterceptor extends InterceptorsWrapper {
  final Dio _dio;

  APIInterceptor(this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final tokens = await getTokens();
    options.headers['Authorization'] = 'Bearer ${tokens.access}';
    log("options: ${options.data}");
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final sc = err.response?.statusCode ?? 0;
    if (sc == 401) {
      await onAccessExpired(err, handler);
    } else {
      return super.onError(err, handler);
    }
  }

  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) async {
  //   return super.onResponse(response, handler);
  // }

  Future<void> onAccessExpired(DioException err, ErrorInterceptorHandler handler) async {
    final message = "${err.response?.data["message"]}";
    final isAccesExpired = message.contains("Akses token");
    final isRefreshExpired = message.contains("Waktu login sudah habis");
    if (isAccesExpired) {
      try {
        await refreshAccessToken();
        final tokens = await getTokens();
        err.requestOptions.headers["Authorization"] = "Bearer ${tokens.access}";
        final opts = Options(method: err.requestOptions.method, headers: err.requestOptions.headers);
        final prevRequest = await _dio.request(
          err.requestOptions.path,
          options: opts,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );
        return handler.resolve(prevRequest);
      } on DioException catch (e) {
        // TODO: Remove Snackbar during production!
        showErrorSnackbar(
          title: "Error ${e.response?.statusCode ?? ''}",
          message: e.response != null ? e.response!.data['message'].toString() : e.message!,
        );
        return super.onError(err, handler);
      }
    } else if (isRefreshExpired) {
      Get.offAllNamed(AppRoutes.authLibrary);
      return super.onError(err, handler);
    } else {
      // TODO: Remove Snackbar during production!
      showErrorSnackbar(
        title: "Error ${err.response?.statusCode ?? ''}",
        message: err.response != null ? err.response!.data['message'].toString() : err.message!,
      );
      return super.onError(err, handler);
    }
  }

  Future<void> refreshAccessToken() async {
    final oldTokens = await getTokens();
    final response = await _dio.post(
      APIPath.refresh,
      data: jsonEncode({"token": oldTokens.refresh}),
    );
    final sc = response.statusCode ?? 0;
    if (sc >= 200 && sc < 300) {
      final access = response.data['result']['token']['accessToken'];
      await SharedPreferencesManager.writePref("access", access);
    }
  }
}
