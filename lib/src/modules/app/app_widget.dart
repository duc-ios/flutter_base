import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../generated/l10n.dart';
import '../../common/theme/app_theme.dart';
import '../../common/theme/app_theme_wrapper.dart';
import '../../common/utils/getit_utils.dart';
import '../../core/application/auth_bloc/auth_bloc.dart';
import '../../core/application/lang_cubit/lang_cubit.dart';
import 'app_router.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>();
    final talker = getIt<Talker>();
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => Consumer(
        builder: (context, ref, _) {
          ref.listen(authProvider, (_, current) {
            final router = getIt<AppRouter>();
            current.whenOrNull(
                authenticated: (user) => router.replaceAll([const HomeRoute()]),
                unauthenticated: () => router.replaceAll([const AuthRoute()]));
          });
          final locale = ref.watch(langProvider);
          return AppThemeWrapper(
              appTheme: AppTheme.create(locale),
              builder: (BuildContext context, ThemeData themeData) {
                return MaterialApp.router(
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  locale: locale,
                  theme: themeData,
                  routerConfig: router.config(
                    navigatorObservers: () => [TalkerRouteObserver(talker)],
                  ),
                );
              });
        },
      ),
    );
  }
}
