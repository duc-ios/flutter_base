import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

mixin CancelableBlocBase<T> on BlocBase<T> {
  CancelToken? cancelToken = CancelToken();

  @override
  Future<void> close() async {
    cancel(); // cancel async tasks when bloc/cubit was disposed.
    super.close();
  }

  void cancel([dynamic reason]) {
    cancelToken?.cancel(reason);
    cancelToken = CancelToken();
  }
}
