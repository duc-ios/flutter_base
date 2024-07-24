part of 'supportive_cubit.dart';

@freezed
class SupportiveState with _$SupportiveState {
  const factory SupportiveState.error(ApiError error) = _Error;
  const factory SupportiveState.loading() = _Loading;
  const factory SupportiveState.loaded({
    required String html,
  }) = _Loaded;
}

extension SupportiveStateX on SupportiveState {
  SupportiveState onError(ApiError error) => _Error(error);
  SupportiveState onLoaded(String html) => _Loaded(html: html);
}
