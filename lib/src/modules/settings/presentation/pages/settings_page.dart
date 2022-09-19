import 'package:flutter_base/src/common/extensions/build_context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/cubits/auth_cubit/auth/auth_cubit.dart';
import '../widgets/settings_body.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: Text(context.s.settings)),
        body: state.maybeWhen(
          orElse: () => const Center(child: CircularProgressIndicator()),
          authenticated: () => const SettingsBody(),
        ),
      ),
    );
  }
}
