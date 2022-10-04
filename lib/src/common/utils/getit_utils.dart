import 'package:get_it/get_it.dart';

import '../../core/application/cubits/auth/auth_cubit.dart';
import '../../core/application/cubits/lang/lang_cubit.dart';
import '../../core/infrastructure/datasources/remote/api/api_client.dart';
import '../../core/infrastructure/repositories/lang_repository.dart';
import '../../modules/app/app_router.dart';
import '../../modules/auth/infrastructure/repositories/auth_repository.dart';
import 'environment.dart';

final getIt = GetIt.instance;

class GetItUtils {
  static setup() async {
    final apiClient = ApiClient(Environment.apiUrl);
    getIt.registerSingleton(apiClient);

    getIt.registerLazySingleton(() => LangRepository());
    getIt.registerLazySingleton(() => AuthRepository(apiClient));

    getIt.registerSingleton(AppRouter());
    getIt.registerSingleton(AuthCubit(getIt<AuthRepository>()));
    getIt.registerSingleton(LangCubit(getIt<LangRepository>()));
  }
}
