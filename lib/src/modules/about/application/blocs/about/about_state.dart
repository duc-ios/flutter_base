part of 'about_bloc.dart';

@freezed
class AboutState with _$AboutState {
  const factory AboutState.show() = _StateShow;
  const factory AboutState.hide() = _StateHide;
}
