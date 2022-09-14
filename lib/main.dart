import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:hive_flutter/adapters.dart';

import 'src/modules/app/app_localization.dart';
import 'src/common/constants/constants.dart';
import 'src/core/presentation/cubits/auth_cubit/auth/auth_cubit.dart';
import 'src/modules/app/app_router.dart';
import 'src/modules/app/app_widget.dart';
import 'src/modules/auth/data/models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await EasyLocalization.ensureInitialized();

  Hive.registerAdapter(UserModelAdapter());
  await Hive.initFlutter();
  await Hive.openBox('box');
  setupGetIt();

  runApp(
    AppLocalization(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<AuthCubit>()),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthCubit, AuthState>(listener: (context, state) {
              final router = getIt<AppRouter>();
              state.whenOrNull(
                  authenticated: () => router.replaceAll([const HomeRoute()]),
                  unauthenticated: () =>
                      router.replaceAll([const AuthRoute()]));
            }),
          ],
          child: const AppWidget(),
        ),
      ),
    ),
  );
}

void setupGetIt() {
  getIt.registerSingleton<AppRouter>(AppRouter());
  getIt.registerSingleton<AuthCubit>(AuthCubit());
}
