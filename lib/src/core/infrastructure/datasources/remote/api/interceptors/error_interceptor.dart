import 'package:dio/dio.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../../common/extensions/optional_x.dart';
import '../../../../../../common/utils/getit_utils.dart';
import '../../../../../../modules/auth/domain/interfaces/auth_repository_interface.dart';
import '../base/api_error.dart';

class ErrorInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final error = response.data['error'];
    if (error != null) {
      throw ApiError.server(
        code: error['code'],
        message: error['message'],
      );
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    var error = err.error;
    if (error is ApiError) {
      return super.onError(err, handler);
    }
    if (err.type == DioExceptionType.cancel) {
      error = ApiError.cancelled();
    } else {
      error = _parseApiErrorFromDioException(err);
    }

    super.onError(err.copyWith(error: error), handler);
  }

  static ApiError resolve(DioException err) {
    if (err.type == DioExceptionType.cancel) {
      return ApiError.cancelled();
    } else if (err.error is ApiError) {
      return err.error.asOrNull();
    } else {
      return _parseApiErrorFromDioException(err);
    }
  }

  static ApiError _parseApiErrorFromDioException(DioException err) {
    final code = err.response?.statusCode ?? -1;
    final message = _getErrMessage(err.response,
        msg: err.message ?? S.current.error_unexpected);
    if (code == 401) {
      getIt<IAuthRepository>().logout();
      return ApiError.unauthorized(message);
    } else if (code >= 400 && code < 500) {
      final error = ApiError.server(code: code, message: message);
      return error;
    } else {
      final error = ApiError.network(code: code, message: message);
      return error;
    }
  }

  static String _getErrMessage(
    Response<dynamic>? response, {
    String msg = '',
  }) {
    try {
      return response?.data['message'] ?? msg;
    } catch (error) {
      return msg;
    }
  }
}
