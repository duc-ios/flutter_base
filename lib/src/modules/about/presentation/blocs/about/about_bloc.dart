import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'about_bloc.freezed.dart';
part 'about_event.dart';
part 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc() : super(const _StateHide()) {
    on<AboutEvent>((event, emit) => emit(
          event.when(
            show: () => const _StateShow(),
            hide: () => const _StateHide(),
          ),
        ));
  }
}
