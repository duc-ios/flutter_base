import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: const Scaffold(
        body: HomeBody(),
      ),
    );
  }
}
