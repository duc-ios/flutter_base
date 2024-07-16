import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../common/extensions/build_context_x.dart';
import '../../../../core/application/auth_bloc/auth_bloc.dart';
import '../../../app/app_router.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer(
            builder: (context, ref, _) => ref.watch(authProvider).maybeWhen(
                  orElse: () => Text(context.s.error_unexpected),
                  authenticated: (user) => CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar),
                    radius: 100,
                  ),
                ),
          ),
          const Gap(8),
          Consumer(
            builder: (context, ref, _) => ref.watch(authProvider).maybeWhen(
                orElse: () => Text(context.s.error_unexpected),
                authenticated: (user) => Text(context.s.hello(user.name),
                    textAlign: TextAlign.center,
                    style: context.textTheme.headlineMedium)),
          ),
          const Gap(32),
          ElevatedButton(
            onPressed: () => context.pushRoute(const CounterRoute()),
            child: Text(context.s.counter),
          ),
          const Gap(16),
          ElevatedButton(
            onPressed: () => context.pushRoute(const SettingsRoute()),
            child: Text(context.s.settings),
          ),
        ],
      ),
    );
  }
}
