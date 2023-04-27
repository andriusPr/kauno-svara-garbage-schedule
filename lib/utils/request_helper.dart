import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:home/constants/garbage_constants.dart';
import 'package:home/constants/request_constants.dart';

const bool isProduction = bool.fromEnvironment('dart.vm.product');

class DioApi {
  static Dio? _instance;

  DioApi._internal();

  static Dio getInstance() {
    if (_instance != null) {
      return _instance!;
    }

    _instance = Dio(DioApi._getInstanceOptions())
      ..interceptors.add(DioCacheManager(CacheConfig(defaultMaxAge: requestCacheTtl)).interceptor);

    if (isProduction == false) {
      addDevInterceptors(_instance!);
    }

    return _instance!;
  }

  static BaseOptions _getInstanceOptions() {
    return BaseOptions(
      listFormat: ListFormat.multiCompatible,
      connectTimeout: 3000,
      receiveTimeout: 3000,
      baseUrl: garbageApiBaseUrl,
    );
  }

  static Dio addDevInterceptors(Dio dio) {
    return dio
      ..interceptors.add(
        LogInterceptor(
          request: true,
          responseBody: true,
          requestBody: true,
          requestHeader: true,
        ),
      );
  }
}
