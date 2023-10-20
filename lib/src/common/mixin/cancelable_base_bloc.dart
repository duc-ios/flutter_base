import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

mixin CancelableBaseBloc<T> on BlocBase<T> {
  CancelToken? cancelToken = CancelToken();

  @override
  Future<void> close() async {
    cancel(); //cancel async if bloc/cubit disposed.
    super.close();
  }

  void cancel([dynamic reason]) {
    cancelToken?.cancel(reason);
    cancelToken = CancelToken();
  }

  @override
  void emit(state) {
    if (isClosed) return;
    super.emit(state);
  }
}
