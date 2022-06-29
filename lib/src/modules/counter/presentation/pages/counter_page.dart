import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/counter/counter_bloc.dart';
import '../cubits/tap/tap_cubit.dart';

import '../widgets/counter_body.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => CounterBloc()),
      BlocProvider(create: (_) => TapCubit()),
    ], child: const CounterBody());
  }
}
