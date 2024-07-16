import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import '../widgets/counter_body.dart';

@RoutePage()
class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CounterBody();
  }
}
