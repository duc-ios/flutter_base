import 'package:get_it/get_it.dart';

import '../../modules/auth/application/auth_service.dart';
import '../../core/application/lang_service.dart';
import '../../modules/auth/infrastructure/repositories/auth_repository.dart';
import '../../core/infrastructure/repositories/lang_repository.dart';
import '../../core/presentation/cubits/auth_cubit/auth/auth_cubit.dart';
import '../../core/presentation/cubits/lang_cubit/lang_cubit.dart';
import '../../modules/app/app_router.dart';

final getIt = GetIt.instance;

class GetItUtils {
  static setup() async {
    getIt.registerLazySingleton(() => LangRepository());
    getIt.registerLazySingleton(() => LangService(getIt()));
    getIt.registerLazySingleton(() => AuthRepository());
    getIt.registerLazySingleton(() => AuthService(getIt()));

    getIt.registerSingleton(AppRouter());
    getIt.registerSingleton(AuthCubit(getIt()));
    getIt.registerSingleton(LangCubit(getIt()));
  }
}
