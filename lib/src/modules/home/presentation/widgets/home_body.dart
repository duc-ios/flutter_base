import 'package:auto_route/auto_route.dart';
import 'package:flutter_base/src/common/extensions/build_context_x.dart';
import 'package:flutter/material.dart';

import '../../../../common/utils/hive_utils.dart';
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
          Text(context.s.hello((box.get('user') as UserModel).name),
              style: context.textTheme.headline4),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => context.router.push(const CounterRoute()),
            child: Text(context.s.counter),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.router.push(const SettingsRoute()),
            child: Text(context.s.settings),
          ),
        ],
      ),
    );
  }
}
