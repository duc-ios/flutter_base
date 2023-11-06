import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/extensions/build_context_dialog.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../application/blocs/counter/counter_bloc.dart';
import '../../application/cubits/tap/tap_cubit.dart';

class CounterBody extends StatelessWidget {
  const CounterBody({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return MultiBlocListener(
      listeners: [
        BlocListener<CounterBloc, CounterState>(listener: (_, state) {
          state.whenOrNull(failure: (error) => context.showError(error));
        }),
        BlocListener<TapCubit, TapState>(listener: (_, state) {
          state.whenOrNull(failure: (error) => context.showError(error));
        }),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(context.s.counter)),
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            BlocBuilder<CounterBloc, CounterState>(
                buildWhen: (previous, current) =>
                    current.whenOrNull(failure: (failure) => false) ?? true,
                builder: (_, state) {
                  return state.whenOrNull(
                        loading: () => const CircularProgressIndicator(),
                        value: (value) => Text('value: $value',
                            style: textTheme.displayMedium),
                      ) ??
                      const SizedBox();
                }),
            BlocBuilder<TapCubit, TapState>(
                buildWhen: (previous, current) =>
                    current.whenOrNull(failure: (failure) => false) ?? true,
                builder: (_, state) {
                  return state.whenOrNull(
                        value: (value) =>
                            Text('tap: $value', style: textTheme.displayMedium),
                      ) ??
                      const SizedBox();
                })
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
                context.read<TapCubit>().tap();
                context
                    .read<CounterBloc>()
                    .add(const CounterEvent.increasement());
              },
            ),
            const SizedBox(height: 8),
            FloatingActionButton(
              heroTag: 'counterView_decrement_floatingActionButton',
              child: const Icon(Icons.remove),
              onPressed: () {
                context.read<TapCubit>().tap();
                context
                    .read<CounterBloc>()
                    .add(const CounterEvent.decreasement());
              },
            ),
          ],
        ),
      ),
    );
  }
}
