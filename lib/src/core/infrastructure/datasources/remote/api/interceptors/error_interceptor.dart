import 'package:dio/dio.dart';

import '../../../../../../../generated/l10n.dart';
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
  void onError(DioError err, ErrorInterceptorHandler handler) {
    var error = err.error;
    if (error is ApiError) {
      return super.onError(err, handler);
    }

    if (err.type == DioErrorType.cancel) {
      error = ApiError.cancelled();
    } else {
      final statusCode = err.response?.statusCode ?? -1;
      if (statusCode == 401) {
        getIt<IAuthRepository>().logout();
        error = ApiError.unauthorized();
      } else if (statusCode >= 400 && statusCode < 500) {
        error = ApiError.server(
          code: statusCode,
          message: err.message ?? S.current.error_unexpected,
        );
      } else {
        error = ApiError.network();
      }
    }

    super.onError(err.copyWith(error: error), handler);
  }
}
