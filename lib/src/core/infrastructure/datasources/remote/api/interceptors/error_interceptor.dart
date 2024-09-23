import 'package:dio/dio.dart';

import '../../../../../../common/utils/getit_utils.dart';
import '../../../../../../modules/auth/domain/interfaces/auth_repository.dart';
import '../../../../../domain/errors/api_error.dart';

class ErrorInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data is Map<String, dynamic>) {
      final data = response.data;
      if (data is String) {
        throw ApiError.internal(data);
      } else if (data is Map<String, dynamic>) {
        final error = data['error'];
        if (error is Map<String, dynamic>) {
          final message = error['message'];
          if (message is String) {
            final apiError = ApiError.server(
              code: response.statusCode,
              message: message,
            );
            throw apiError;
          }
        }
      }
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;

    if (statusCode == null) throw ApiError.unexpected();

    switch (statusCode) {
      case >= 200 && < 300:
        return handler.next(err);
      case 401:
        getIt<AuthRepository>().logout();
        return handler.reject(err);
      case >= 400 && < 500:
        final data = err.response?.data;
        if (data is String) {
          throw ApiError.internal(data);
        } else if (data is Map<String, dynamic>) {
          final error = data['error'];
          if (error is Map<String, dynamic>) {
            final message = error['message'];
            if (message is String) {
              final apiError = ApiError.server(
                code: statusCode,
                message: message,
              );
              throw apiError;
            }
          }
          throw ApiError.unexpected();
        }
      default:
        throw ApiError.unexpected();
    }
    return handler.next(err);
  }
}
