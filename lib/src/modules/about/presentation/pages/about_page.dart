import 'package:flutter_base/src/common/extensions/build_context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/about/about_bloc.dart';
import '../widgets/about_body.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.s.about)),
      body: BlocProvider(
        create: (context) => AboutBloc(),
        child: const AboutBody(),
      ),
    );
  }
}
