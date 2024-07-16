import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../common/extensions/build_context_dialog.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../application/blocs/counter/counter_bloc.dart';
import '../../application/cubits/tap/tap_cubit.dart';

class CounterBody extends ConsumerWidget {
  const CounterBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(counterProvider, (_, current) {
      current.whenOrNull(failure: (error) => context.showError(error));
    });
    ref.listen(
        tapProvider,
        (_, current) =>
            current.whenOrNull(failure: (error) => context.showError(error)));

    final textTheme = context.textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(context.s.counter)),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ref.watch(counterProvider).whenOrNull(
                    loading: () => const CircularProgressIndicator(),
                    value: (value) =>
                        Text('value: $value', style: textTheme.displayMedium),
                  ) ??
              const SizedBox.shrink(),
          ref.watch(tapProvider).whenOrNull(
                    value: (value) =>
                        Text('tap: $value', style: textTheme.displayMedium),
                  ) ??
              const SizedBox.shrink()
        ]),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'counterView_increment_floatingActionButton',
            child: const Icon(Icons.add),
            onPressed: () {
              ref.read(tapProvider.bloc).tap();
              ref
                  .read(counterProvider.bloc)
                  .add(const CounterEvent.increasement());
            },
          ),
          const Gap(8),
          FloatingActionButton(
            heroTag: 'counterView_decrement_floatingActionButton',
            child: const Icon(Icons.remove),
            onPressed: () {
              ref.read(tapProvider.bloc).tap();
              ref
                  .read(counterProvider.bloc)
                  .add(const CounterEvent.decreasement());
            },
          ),
        ],
      ),
    );
  }
}
