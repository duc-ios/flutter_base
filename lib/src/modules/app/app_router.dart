import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import '../../modules/about/presentation/pages/about_page.dart';
import '../../modules/auth/presentation/pages/auth_page.dart';
import '../../modules/counter/presentation/pages/counter_page.dart';
import '../../modules/home/presentation/pages/home_page.dart';
import '../../modules/splash/presentation/pages/splash_page.dart';
import '../settings/presentation/pages/settings_page.dart';
import '../supportive/presentation/pages/supportive_page.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: HomePage),
    AutoRoute(page: AuthPage),
    AutoRoute(page: CounterPage),
    AutoRoute(page: AboutPage),
    AutoRoute(page: SettingsPage),
    AutoRoute(page: SupportivePage),
  ],
)
@singleton
class AppRouter extends _$AppRouter {}
