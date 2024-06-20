import 'package:dio/dio.dart';

import '../../../../../../common/utils/getit_utils.dart';
import '../../../../../../modules/auth/domain/interfaces/auth_repository_interface.dart';
import '../base/api_error.dart';

class ErrorInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data is Map<String, dynamic>) {
      final error = response.data['error'];
      if (error != null) {
        throw ApiError.server(
          code: error['code'],
          message: error['message'],
        );
      }
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      getIt<IAuthRepository>().logout();
      handler.reject(err);
    } else {
      handler.next(err);
    }
  }
}
