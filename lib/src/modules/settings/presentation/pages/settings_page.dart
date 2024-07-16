import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/extensions/build_context_x.dart';
import '../../../../core/application/auth_bloc/auth_bloc.dart';
import '../widgets/settings_body.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) => Scaffold(
        appBar: AppBar(title: Text(context.s.settings)),
        body: ref.watch(authProvider).maybeWhen(
              orElse: () => const Center(child: CircularProgressIndicator()),
              authenticated: (user) => const SettingsBody(),
            ),
      ),
    );
  }
}
