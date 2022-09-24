import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'counter_bloc.freezed.dart';
part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const _Value(0)) {
    on<CounterEvent>((event, emit) async {
      await event.when(
          increasement: () async => add(const CounterEvent.add(1)),
          decreasement: () async => add(const CounterEvent.add(-1)),
          add: (value) async {
            final newValue = _value + value;
            if (newValue > 5) {
              emit(const _Failure('value must be < 5'));
            } else if (newValue < 0) {
              emit(const _Failure('value must be >= 0'));
            } else {
              emit(const _Loading());
              await Future.delayed(const Duration(milliseconds: 500));
              emit(_Value(newValue));
              _value = newValue;
            }
          });
    });
  }

  var _value = 0;
}
