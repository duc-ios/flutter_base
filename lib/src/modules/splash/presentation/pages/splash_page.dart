import 'package:flutter/material.dart';
import '../../../../common/extensions/int_duration.dart';

import '../../../../common/utils/getit_utils.dart';
import '../../../../core/presentation/cubits/auth_cubit/auth/auth_cubit.dart';
import '../../../app/app_router.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key) {
    fetchAll();
  }

  fetchAll() async {
    await Future.delayed(1.seconds);

    getIt<AuthCubit>().state.whenOrNull(
          authenticated: () =>
              getIt<AppRouter>().replaceAll([const HomeRoute()]),
          unauthenticated: () =>
              getIt<AppRouter>().replaceAll([const AuthRoute()]),
        );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
