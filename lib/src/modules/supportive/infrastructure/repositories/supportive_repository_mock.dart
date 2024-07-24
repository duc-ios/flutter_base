import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../common/extensions/int_duration.dart';
import '../../../../common/utils/app_environment.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../domain/repositories/supportive_repository.dart';

@alpha
@LazySingleton(as: SupportiveRepository)
class SupportiveRepositoryMock implements SupportiveRepository {
  @override
  Future<Result<String, ApiError>> getSupportive(String slug,
      {CancelToken? cancelToken}) async {
    await Future.delayed(1.seconds);
    return List.generate(100, (_) => slug).joinToString().toSuccess();
  }
}
