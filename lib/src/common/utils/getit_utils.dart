import 'package:get_it/get_it.dart';

import '../../core/presentation/cubits/auth_cubit/auth/auth_cubit.dart';
import '../../core/presentation/cubits/lang_cubit/lang_cubit.dart';
import '../../modules/app/app_router.dart';

final getIt = GetIt.instance;

class GetItUtils {
  static setup() async {
    getIt.registerSingleton<AppRouter>(AppRouter());
    getIt.registerSingleton<AuthCubit>(AuthCubit());
    getIt.registerSingleton<LangCubit>(LangCubit());
  }
}
