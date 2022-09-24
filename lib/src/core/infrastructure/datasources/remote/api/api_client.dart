import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../local/storage.dart';
import 'base/api_error.dart';
import 'base/api_path.dart';
import 'base/api_response.dart';
import 'interceptors/api_log_interceptor.dart';
import 'interceptors/auth_interceptor.dart';

class ApiClient {
  final String baseUrl;

  late final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    headers: {
      'lang': Storage.lang,
      'device_id': Storage.deviceId,
    },
  ))
    ..interceptors.addAll([
      AuthInterceptor(),
      ApiLogInterceptor(),
    ]);

  ApiClient(this.baseUrl);

  Future<Either<ApiError, ApiResponse<T>>> request<T>(
    APIPath path,
    T Function(Object?) fromJsonT, {
    data,
    Options? options,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.fetch(
        (options ?? Options(method: path.method)).compose(
          _dio.options,
          path.path,
          data: data,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ),
      );

      final error = response.data['error'];
      if (error != null) {
        return left(
          ApiError.server(code: error['code'], message: error['message']),
        );
      } else {
        final data = response.data['data'];
        if (data is List) {
          return right(
            ListApiResponse.fromJson(response.data, fromJsonT),
          );
        } else {
          return right(
            SingleApiResponse.fromJson(response.data, fromJsonT),
          );
        }
      }
    } on DioError catch (error) {
      final statusCode = error.response?.statusCode ?? -1;
      if (statusCode == 401) {
        return left(
          ApiError.unauthorized(),
        );
      } else {
        return left(
          ApiError.network(
              code: error.response?.statusCode, message: error.message),
        );
      }
    } catch (error) {
      return left(
        ApiError.internal(message: error.toString()),
      );
    }
  }
}

extension A<T> on Either<ApiError, ApiResponse<T>> {
  Either<ApiError, T> get single => fold(
        (l) => left(l),
        (r) => (r.data is T)
            ? right(r.data)
            : left(
                ApiError.unexpected(),
              ),
      );

  Either<ApiError, List<T>> get list => fold(
        (l) => left(l),
        (r) => (r.data is List<T>)
            ? right(r.data)
            : left(
                ApiError.unexpected(),
              ),
      );
}
