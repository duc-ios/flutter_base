import 'package:bloc/bloc.dart';
import '../../../../../common/extensions/int_duration.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../common/utils/hive_utils.dart';
import '../../../../../modules/auth/data/models/user_model.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : super((box.get('user') is UserModel)
            ? const AuthState.authenticated()
            : const AuthState.unauthenticated());

  void set(UserModel user) {
    box.put('user', user);
    emit(const AuthState.authenticated());
  }

  Future<void> login(String name) async {
    emit(const AuthState.loading());
    await Future.delayed(1.seconds);
    set(UserModel(name));
    emit(const AuthState.authenticated());
  }

  void logout() async {
    emit(const AuthState.loading());
    await Future.delayed(1.seconds);
    box.delete('user');
    emit(const AuthState.unauthenticated());
  }
}
