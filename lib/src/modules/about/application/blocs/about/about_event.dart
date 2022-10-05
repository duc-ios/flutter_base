part of 'about_bloc.dart';

@freezed
class AboutEvent with _$AboutEvent {
  const factory AboutEvent.show() = _EventShow;
  const factory AboutEvent.hide() = _EventHide;
}
