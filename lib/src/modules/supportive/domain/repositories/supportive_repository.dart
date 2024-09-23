import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/domain/errors/api_error.dart';

abstract class SupportiveRepository {
  Future<Result<String, ApiError>> getSupportive(String slug,
      {CancelToken? cancelToken});
}
