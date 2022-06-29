import 'package:flutter/material.dart';

import '../widgets/home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeBody(),
    );
  }
}
