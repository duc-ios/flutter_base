import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/extensions/locale_x.dart';
import '../../../../core/presentation/cubits/auth_cubit/auth/auth_cubit.dart';
import '../../../../core/presentation/cubits/lang_cubit/lang_cubit.dart';
import '../../../app/app_router.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({
    Key? key,
  }) : super(key: key);

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
          onTap: () => context.router.push(const AboutRoute()),
        ),
        ListTile(
          title: Text(context.s.terms_conditions),
          onTap: () => context.router.push(SupportiveRoute(
            title: context.s.terms_conditions,
            content: '''
Ex cillum cillum deserunt labore ea cupidatat consectetur irure labore esse commodo nisi. Nulla culpa voluptate consectetur eiusmod nisi veniam ut. Enim ex culpa enim occaecat ex.
Commodo deserunt officia id ad occaecat id voluptate sint pariatur consectetur eu. Cillum eiusmod laboris tempor ea et quis duis quis sint cupidatat do. Laboris deserunt esse ut ullamco adipisicing Lorem consectetur pariatur sit amet minim reprehenderit consectetur.
In id sint aute id ipsum deserunt fugiat tempor nulla proident aliqua nulla non. Ut voluptate reprehenderit deserunt aliqua reprehenderit elit. Velit cillum amet cillum consequat nulla. Commodo incididunt laboris fugiat proident occaecat proident adipisicing velit nisi ut aliquip Lorem laborum. Officia est cillum officia ut reprehenderit proident Lorem dolore consequat.
Deserunt eiusmod est ut ut exercitation aliquip eu consequat eu exercitation aliqua mollit voluptate. Occaecat aute labore dolore dolore cupidatat incididunt. Laborum dolore voluptate aute eiusmod. Fugiat occaecat eu aliqua aute cupidatat eiusmod culpa deserunt. Aliqua proident voluptate do commodo do excepteur ex ut quis culpa cillum proident. Laborum elit aliquip eu ad minim non dolor aliquip.''',
          )),
        ),
        ListTile(
          title: Text(context.s.privacy_policies),
          onTap: () => context.router.push(SupportiveRoute(
            title: context.s.privacy_policies,
            content: '''
Et incididunt minim tempor anim. Eiusmod cupidatat dolore est nulla. Cillum eu excepteur qui aliquip ullamco qui excepteur excepteur do esse labore minim voluptate. Minim deserunt tempor excepteur ipsum voluptate nulla aliquip elit aute culpa laborum aliquip mollit eu.
Ea consectetur magna tempor officia do mollit reprehenderit proident esse culpa commodo culpa proident. Sit aliquip quis ea aliqua ullamco ad. Consequat labore consequat nostrud qui minim ea sit eiusmod laboris do incididunt.
Aute adipisicing aliqua velit ullamco cupidatat dolore sunt sint. Officia dolor cupidatat exercitation consectetur aliquip reprehenderit velit. Ad cillum sunt proident nostrud in exercitation. Enim nostrud voluptate duis duis ut velit id culpa labore ipsum ullamco fugiat. Incididunt est tempor irure velit aliquip est commodo id sit. Tempor qui nisi ex officia quis aute reprehenderit elit Lorem esse sit aliqua ullamco. Quis do amet veniam consectetur dolore reprehenderit pariatur laboris adipisicing id et.
Amet cupidatat dolore fugiat esse. Et occaecat ullamco id amet Lorem in dolore fugiat. Consectetur amet id mollit nostrud do excepteur sint aliqua laborum velit. Consequat sunt esse Lorem Lorem proident commodo. Enim aute elit consectetur ex sint Lorem. Consectetur eiusmod veniam deserunt consectetur duis fugiat adipisicing aliqua aliqua officia dolor.''',
          )),
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
                    style: context.textTheme.caption,
                  );
                }
                return const SizedBox();
              }),
        ),
      ],
    );
  }
}
