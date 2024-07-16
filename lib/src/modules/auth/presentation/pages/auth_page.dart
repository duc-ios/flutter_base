import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../common/extensions/build_context_dialog.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../core/application/auth_bloc/auth_bloc.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/auth/models/login_request.dart';
import '../../../../common/widgets/loading_widget.dart';

part '../widgets/auth_body.dart';
part '../widgets/email_widget.dart';
part '../widgets/password_widget.dart';

@RoutePage()
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
        child: const AuthBody(),
      ),
    );
  }
}
