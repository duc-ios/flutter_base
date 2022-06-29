import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../common/constants/constants.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../app/app_router.dart';
import '../../../auth/data/models/user_model.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 32),
          Text(
              LocaleKeys.hello
                  .tr(namedArgs: {'name': (box.get('user') as UserModel).name}),
              style: context.textTheme.headline4),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => context.router.push(const CounterRoute()),
            child: Text(LocaleKeys.counter.tr()),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.router.push(const SettingsRoute()),
            child: Text(LocaleKeys.settings.tr()),
          ),
        ],
      ),
    );
  }
}
