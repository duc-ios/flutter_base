import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';

import 'src/common/extensions/locale_x.dart';
import 'src/common/utils/getit_utils.dart';
import 'src/common/utils/global_bloc_observer.dart';
import 'src/common/utils/logger.dart';
import 'src/core/application/cubits/auth_cubit/auth/auth_cubit.dart';
import 'src/core/application/cubits/lang_cubit/lang_cubit.dart';
import 'src/core/infrastructure/datasources/local/storage.dart';
import 'src/core/infrastructure/repositories/lang_repository.dart';
import 'src/modules/app/app_router.dart';
import 'src/modules/app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterConfig.loadEnvVariables();
  await Storage.setup();
  await GetItUtils.setup();

  final langRepository = getIt<LangRepository>();
  logger
      .d('deviceLocale - ${langRepository.getDeviceLocale().fullLanguageCode}');
  logger.d('currentLocale - ${langRepository.getLocale().fullLanguageCode}');

  if (!kReleaseMode) {
    Bloc.observer = GlobalBlocObserver();
  }
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthCubit>()),
        BlocProvider(create: (_) => getIt<LangCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, AuthState>(listener: (context, state) {
            final router = getIt<AppRouter>();
            state.whenOrNull(
                authenticated: (user) => router.replaceAll([const HomeRoute()]),
                unauthenticated: () => router.replaceAll([const AuthRoute()]));
          }),
        ],
        child: const AppWidget(),
      ),
    ),
  );
}
