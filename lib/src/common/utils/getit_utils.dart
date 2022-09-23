import 'package:get_it/get_it.dart';

import '../../core/application/cubits/auth_cubit/auth/auth_cubit.dart';
import '../../core/application/cubits/lang_cubit/lang_cubit.dart';
import '../../core/infrastructure/repositories/lang_repository.dart';
import '../../modules/app/app_router.dart';
import '../../modules/auth/infrastructure/repositories/auth_repository.dart';

final getIt = GetIt.instance;

class GetItUtils {
  static setup() async {
    getIt.registerLazySingleton(() => LangRepository());
    getIt.registerLazySingleton(() => AuthRepository());

    getIt.registerSingleton(AppRouter());
    getIt.registerSingleton(AuthCubit(getIt()));
    getIt.registerSingleton(LangCubit(getIt()));
  }
}
