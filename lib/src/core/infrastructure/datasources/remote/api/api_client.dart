import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../../common/utils/app_environment.dart';
import '../../../../domain/interfaces/lang_repository_interface.dart';
import '../../local/storage.dart';
import 'base/api_error.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/lang_interceptor.dart';

@module
abstract class ApiModule {
  @Named('baseUrl')
  String get baseUrl => AppEnvironment.apiUrl;

  @singleton
  Dio dio(
    @Named('baseUrl') String url,
    ILangRepository repo,
    Talker talker,
  ) =>
      Dio(
        BaseOptions(
          baseUrl: url,
          headers: {'accept': 'application/json'},
          queryParameters: {
            'device_id': Storage.deviceId,
          },
        ),
      )..interceptors.addAll([
          LangInterceptor(repo),
          AuthInterceptor(),
          TalkerDioLogger(
            talker: talker,
            settings: TalkerDioLoggerSettings(
              responsePen: AnsiPen()..blue(),
              // All http responses enabled for console logging
              printResponseData: true,
              // All http requests disabled for console logging
              printRequestData: true,
              // Response logs including http - headers
              printResponseHeaders: false,
              // Request logs without http - headers
              printRequestHeaders: true,
            ),
          ),
          ErrorInterceptor(),
        ]);
}

extension FutureX<T extends Object> on Future<T> {
  Future<Result<T, ApiError>> result() async {
    try {
      final result = await this;
      return Success(result);
    } on DioException catch (err) {
      return Failure(ErrorInterceptor.resolve(err));
    } on ApiError catch (err) {
      return Failure(err);
    } catch (error) {
      return Failure(ApiError.internal(error.toString()));
    }
  }
}
