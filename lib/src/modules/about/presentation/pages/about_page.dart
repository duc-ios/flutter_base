import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../common/extensions/build_context_x.dart';
import '../widgets/about_body.dart';

@RoutePage()
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.s.about)),
      body: const AboutBody(),
    );
  }
}
