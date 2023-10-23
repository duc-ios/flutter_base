import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'api_error.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

abstract class GenericObject<T> {
  T Function(Map<String, dynamic>) fromJsonT;

  GenericObject(this.fromJsonT);

  T genericObject(dynamic data) {
    return fromJsonT(data);
  }
}

class ResponseWrapper<T> extends GenericObject<T> {
  late T response;

  ResponseWrapper(super.fromJsonT);

  factory ResponseWrapper.init(
      {required T Function(Map<String, dynamic>) fromJsonT,
      required dynamic data}) {
    final wrapper = ResponseWrapper<T>(fromJsonT);
    wrapper.response = wrapper.genericObject(data);
    return wrapper;
  }
}

@Freezed(genericArgumentFactories: true)
class SingleApiResponse<T> with _$SingleApiResponse<T> {
  const factory SingleApiResponse(T data) = _SingleApiResponse;

  factory SingleApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$SingleApiResponseFromJson(json, fromJsonT);
}

@Freezed(genericArgumentFactories: true)
class ListApiResponse<T> with _$ListApiResponse<T> {
  const factory ListApiResponse(List<T> data) = _ListApiResponse;

  factory ListApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ListApiResponseFromJson(json, fromJsonT);
}

@Freezed(genericArgumentFactories: true)
class PagingApiResponse<T> with _$PagingApiResponse<T> {
  const factory PagingApiResponse({
    required List<T> data,
    required int page,
    required int total,
  }) = _PagingApiResponse;

  factory PagingApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$PagingApiResponseFromJson(json, fromJsonT);
}

extension FoldedSingleApiResponse<T> on Either<ApiError, SingleApiResponse<T>> {
  Either<ApiError, T> get folded => fold((l) => left(l), (r) => right(r.data));
}

extension FoldedListApiResponse<T> on Either<ApiError, ListApiResponse<T>> {
  Either<ApiError, List<T>> get folded =>
      fold((l) => left(l), (r) => right(r.data));
}
