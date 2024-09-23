import 'dart:async';

import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../domain/errors/api_error.dart';

extension FutureOrX<T extends Object> on FutureOr<T> {
  FutureOr<T> getOrThrow() async {
    try {
      return await this;
    } on ApiError {
      rethrow;
    } on DioException catch (e) {
      throw e.toApiError();
    } catch (e) {
      throw ApiError.internal(e.toString());
    }
  }

  FutureOr<Result<R, ApiError>> tryGet<R extends Object>(
      FutureOr<R> Function(T) response) async {
    try {
      return (await response.call(await getOrThrow())).toSuccess();
    } on ApiError catch (e) {
      return e.toFailure();
    } catch (e) {
      return ApiError.internal(e.toString()).toFailure();
    }
  }
}

extension FutureResultX<T extends Object> on Future<Result<T, ApiError>> {
  FutureOr<W> fold<W>(
    W Function(T success) onSuccess,
    W Function(ApiError failure) onFailure,
  ) async {
    try {
      final result = await getOrThrow();
      return onSuccess(result);
    } on ApiError catch (e) {
      return onFailure(e);
    }
  }
}

extension DioExceptionX on DioException {
  ApiError toApiError() {
    final error = this.error;
    if (error is ApiError) {
      return error;
    }
    return ApiError.unexpected();
  }
}
