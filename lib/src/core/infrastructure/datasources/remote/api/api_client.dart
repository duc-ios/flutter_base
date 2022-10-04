import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../local/storage.dart';
import 'base/api_error.dart';
import 'base/api_path.dart';
import 'base/api_response.dart';
import 'interceptors/api_log_interceptor.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';

class ApiClient {
  final String baseUrl;

  late final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {'accept': 'application/json'},
      queryParameters: {
        'lang': Storage.lang,
        'device_id': Storage.deviceId,
      },
    ),
  )..interceptors.addAll([
      AuthInterceptor(),
      ApiLogInterceptor(),
      ErrorInterceptor(),
    ]);

  ApiClient(this.baseUrl);

  Future<Either<ApiError, T>> request<T>({
    required String path,
    required String method,
    required T Function(Map<String, dynamic>) fromJsonT,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  }) async {
    final options = Options(method: method).compose(
      _dio.options,
      path,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
      data: data,
    );

    if (data is FormData) {
      options.data = data;
    } else if (data != null) {
      if (data is Map<String, dynamic> && options.method == ApiMethod.get) {
        final query = Map<String, dynamic>.from(options.queryParameters);
        query.addAll(Map<String, dynamic>.from(data));
        options.queryParameters = query;
      } else {
        options.data = data;
      }
    }
    try {
      final response = await _dio.fetch(options);
      return right(
        ResponseWrapper.init(fromJsonT: fromJsonT, data: response.data)
            .response,
      );
    } on DioError catch (err) {
      return left(err.error);
    } catch (error) {
      return left(ApiError.internal(error.toString()));
    }
  }
}
