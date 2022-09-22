import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';

import 'src/common/extensions/locale_x.dart';
import 'src/common/utils/getit_utils.dart';
import 'src/common/utils/hive_utils.dart';
import 'src/common/utils/logger.dart';
import 'src/core/application/lang_service.dart';
import 'src/core/presentation/cubits/auth_cubit/auth/auth_cubit.dart';
import 'src/core/presentation/cubits/lang_cubit/lang_cubit.dart';
import 'src/modules/app/app_router.dart';
import 'src/modules/app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterConfig.loadEnvVariables();
  await HiveUtils.setup();
  await GetItUtils.setup();

  final langService = getIt<LangService>();
  logger.d('deviceLocale - ${langService.getDeviceLocale().fullLanguageCode}');
  logger.d('currentLocale - ${langService.getLocale().fullLanguageCode}');

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
