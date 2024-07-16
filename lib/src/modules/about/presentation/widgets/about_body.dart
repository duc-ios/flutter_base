import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/extensions/int_duration.dart';
import '../../application/blocs/about/about_bloc.dart';

class AboutBody extends ConsumerWidget {
  const AboutBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(aboutProvider);

    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AnimatedSize(
              duration: 300.milliseconds,
              child: SizedBox(
                  height: ref
                      .read(aboutProvider)
                      .when(show: () => null, hide: () => 0.0),
                  width: context.mediaQuery.size.width,
                  child: const Text(
                    '''
Aliquip consectetur anim est nostrud quis eu nisi nulla enim aliqua labore ad.
Magna nisi nulla do cillum sunt.
Id velit occaecat reprehenderit minim dolore ut in cupidatat culpa nostrud.
Cupidatat sint commodo est consequat sunt officia adipisicing cupidatat in.
                ''',
                  )),
            ),
            OutlinedButton(
              onPressed: () => state.when(
                show: () =>
                    ref.read(aboutProvider.bloc).add(const AboutEvent.hide()),
                hide: () =>
                    ref.read(aboutProvider.bloc).add(const AboutEvent.show()),
              ),
              child: Icon(state.when(
                  show: () => Icons.visibility_off,
                  hide: () => Icons.visibility)),
            )
          ],
        ));
  }
}
