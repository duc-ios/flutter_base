import 'package:flutter/material.dart';

import '../widgets/auth_body.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AuthBody(),
    );
  }
}
