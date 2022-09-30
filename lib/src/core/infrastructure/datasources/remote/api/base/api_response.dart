import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

abstract class DataApiResponse<T> {
  dynamic get data;
}

@Freezed(genericArgumentFactories: true)
class SingleApiResponse<T> extends DataApiResponse<T>
    with _$SingleApiResponse<T> {
  const factory SingleApiResponse({required T data}) = _SingleApiResponse;

  factory SingleApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$SingleApiResponseFromJson(json, fromJsonT);
}

@Freezed(genericArgumentFactories: true)
class ListApiResponse<T> extends DataApiResponse<T> with _$ListApiResponse<T> {
  const factory ListApiResponse({required List<T> data}) = _ListApiResponse;

  factory ListApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ListApiResponseFromJson(json, fromJsonT);
}

@Freezed(genericArgumentFactories: true)
class PagingApiResponse<T> extends DataApiResponse<T>
    with _$PagingApiResponse<T> {
  const factory PagingApiResponse({
    required List<T> data,
    required int page,
    required int total,
  }) = _PagingApiResponse;

  factory PagingApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$PagingApiResponseFromJson(json, fromJsonT);
}
