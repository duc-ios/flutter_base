import 'package:bloc/bloc.dart';

mixin SafeBlocBase<State> on BlocBase<State> {
  @override
  void emit(state) {
    if (isClosed) return;
    super.emit(state);
  }
}
