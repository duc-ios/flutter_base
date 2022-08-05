import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/cubits/auth_cubit/auth/auth_cubit.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../widgets/settings_body.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FIX: https://github.com/aissat/easy_localization/issues/370#issuecomment-986201099
    context.locale;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: Text(LocaleKeys.settings.tr())),
        body: state.maybeWhen(
          orElse: () => const Center(child: CircularProgressIndicator()),
          authenticated: () => const SettingsBody(),
        ),
      ),
    );
  }
}
