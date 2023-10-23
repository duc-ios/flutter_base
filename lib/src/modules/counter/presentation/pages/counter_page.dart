import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/blocs/counter/counter_bloc.dart';
import '../../application/cubits/tap/tap_cubit.dart';
import '../widgets/counter_body.dart';

@RoutePage()
class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => CounterBloc()),
      BlocProvider(create: (_) => TapCubit()),
    ], child: const CounterBody());
  }
}
