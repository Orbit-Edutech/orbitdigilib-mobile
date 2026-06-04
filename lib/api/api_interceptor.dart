import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';

import '../routes/app_routes.dart';
import '../utils/clear_auth_storage.dart';
import '../utils/get_tokens.dart';
import '../utils/shared_preferences_manager.dart';
import 'api_path.dart';

class APIInterceptor extends InterceptorsWrapper {
  final Dio _dio;

  Completer<void>? _refreshLock;

  APIInterceptor(this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final tokens = await getTokens();
    options.headers['Authorization'] = 'Bearer ${tokens.access}';
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final sc = err.response?.statusCode ?? 0;
    if (sc == 401) {
      await _handleUnauthorized(err, handler);
    } else {
      return super.onError(err, handler);
    }
  }

  Future<void> _handleUnauthorized(DioException err, ErrorInterceptorHandler handler) async {
    final reqOpts = err.requestOptions;
    final alreadyRetried = reqOpts.extra['_retry'] == true;
    final isRefreshCall = reqOpts.path == APIPath.refresh;
    final tokens = await getTokens();
    final hasRefresh = (tokens.refresh?.toString() ?? '').isNotEmpty;

    // Tidak bisa recover: refresh-nya sendiri yang 401 (cegah loop), sudah pernah retry,
    // atau tidak ada refresh token sama sekali.
    if (isRefreshCall || alreadyRetried || !hasRefresh) {
      await _forceLogout();
      return super.onError(err, handler);
    }

    // Token akses bermasalah (expired / tidak valid / tidak terkirim) tapi refresh token masih ada.
    // Coba refresh dulu untuk SEMUA 401, bukan hanya pesan "Akses token expired".
    // Logout HANYA kalau refresh-nya sendiri yang gagal.
    try {
      await _refreshAccessTokenLocked();
      final retried = await _retryRequest(reqOpts);
      return handler.resolve(retried);
    } on DioException catch (e) {
      await _forceLogout();
      return super.onError(e, handler);
    }
  }

  Future<void> _refreshAccessTokenLocked() async {
    final existing = _refreshLock;
    if (existing != null && !existing.isCompleted) {
      return existing.future;
    }
    final lock = Completer<void>();
    _refreshLock = lock;
    try {
      await _doRefresh();
      lock.complete();
    } catch (e, st) {
      lock.completeError(e, st);
      rethrow;
    } finally {
      _refreshLock = null;
    }
  }

  Future<void> _doRefresh() async {
    final oldTokens = await getTokens();
    final response = await _dio.post(
      APIPath.refresh,
      data: jsonEncode({"refreshToken": oldTokens.refresh}),
    );
    final sc = response.statusCode ?? 0;
    if (sc >= 200 && sc < 300) {
      final token = response.data['result']['token'];
      final access = token['accessToken'];
      final refresh = token['refreshToken'];
      await SharedPreferencesManager.writePrefs({"access": access, "refresh": refresh});
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Refresh failed with status $sc',
      );
    }
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions reqOpts) async {
    final headers = Map<String, dynamic>.from(reqOpts.headers)..remove('Authorization');
    final opts = Options(
      method: reqOpts.method,
      headers: headers,
      contentType: reqOpts.contentType,
      responseType: reqOpts.responseType,
      extra: {...reqOpts.extra, '_retry': true},
    );
    return _dio.request(
      reqOpts.path,
      options: opts,
      data: reqOpts.data,
      queryParameters: reqOpts.queryParameters,
    );
  }

  Future<void> _forceLogout() async {
    await clearAuthStorage();
    final current = Get.currentRoute;
    final authRoutes = [AppRoutes.authLibrary, AppRoutes.authUser, AppRoutes.authRegister];
    if (!authRoutes.contains(current)) {
      Get.offAllNamed(AppRoutes.authLibrary);
    }
  }
}
