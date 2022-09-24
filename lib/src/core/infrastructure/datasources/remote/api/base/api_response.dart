import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

abstract class ApiResponse<T> {
  dynamic get data;
}

@Freezed(genericArgumentFactories: true)
class SingleApiResponse<T> extends ApiResponse<T> with _$SingleApiResponse<T> {
  const factory SingleApiResponse({required T data}) = _SingleApiResponse;

  factory SingleApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$SingleApiResponseFromJson(json, fromJsonT);
}

@Freezed(genericArgumentFactories: true)
class ListApiResponse<T> extends ApiResponse<T> with _$ListApiResponse<T> {
  const factory ListApiResponse({required List<T> data}) = _ListApiResponse;

  factory ListApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ListApiResponseFromJson(json, fromJsonT);
}
