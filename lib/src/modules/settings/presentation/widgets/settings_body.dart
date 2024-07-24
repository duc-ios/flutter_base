import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/extensions/locale_x.dart';
import '../../../../core/application/cubits/auth/auth_cubit.dart';
import '../../../../core/application/cubits/lang/lang_cubit.dart';
import '../../../app/app_router.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Row(
            children: [
              Text(context.s.language),
              const Spacer(),
              BlocBuilder<LangCubit, Locale>(
                builder: (context, state) {
                  return DropdownButton<Locale>(
                      value: state,
                      items: LocaleX.supportedLocales
                          .map((locale) => DropdownMenuItem(
                                value: locale,
                                child: Text(locale.languageName),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        final langCubit = context.read<LangCubit>();
                        langCubit.setLocale(value);
                      });
                },
              ),
            ],
          ),
        ),
        ListTile(
          title: Text(context.s.about),
          onTap: () => context.pushRoute(const AboutRoute()),
        ),
        ListTile(
          title: Text(context.s.terms_conditions),
          onTap: () => context.pushRoute(SupportiveRoute(
            title: context.s.terms_conditions,
            slug: 'terms_conditions',
          )),
        ),
        ListTile(
          title: Text(context.s.privacy_policies),
          onTap: () => context.pushRoute(
            SupportiveRoute(
              title: context.s.privacy_policies,
              slug: 'privacy_policies',
            ),
          ),
        ),
        ListTile(
          title: Text(context.s.logout),
          onTap: () => context.read<AuthCubit>().logout(),
        ),
        ListTile(
          title: FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                final version = snapshot.data?.version;
                final buildNumber = snapshot.data?.buildNumber;

                if (version != null && buildNumber != null) {
                  return Text(
                    context.s.version_x('$version($buildNumber)'),
                    style: context.textTheme.bodySmall,
                  );
                }
                return const SizedBox();
              }),
        ),
      ],
    );
  }
}
