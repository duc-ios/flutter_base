import 'package:asuka/asuka.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/extensions/build_context_x.dart';
import '../../../../core/presentation/cubits/auth_cubit/auth/auth_cubit.dart';

class AuthBody extends StatefulWidget {
  const AuthBody({Key? key}) : super(key: key);

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> {
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (error) => error.whenOrNull(
              other: (message) => _showError(message),
            ),
          );
        },
        builder: (context, state) {
          if (state == const AuthState.loading()) {
            return const CircularProgressIndicator();
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 16.0,
                children: [
                  TextField(
                    controller: _emailTextEditingController,
                    decoration: InputDecoration(
                      hintText: 'e@ma.il',
                      errorText: state.whenOrNull<String?>(
                        error: (error) => error.whenOrNull(
                          invalidEmail: () => context.s.invalid_email,
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    controller: _passwordTextEditingController,
                    decoration: InputDecoration(
                      hintText: 'aA123456@',
                      errorText: state.whenOrNull<String?>(
                        error: (error) => error.whenOrNull(
                          invalidPassword: () => context.s.invalid_password,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text(context.s.login),
                    onPressed: () => _login(context),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _login(BuildContext context) async {
    final email = _emailTextEditingController.text;
    final password = _passwordTextEditingController.text;
    await context.read<AuthCubit>().login(email: email, password: password);
  }

  void _showError(String message) {
    Asuka.showDialog(
      barrierDismissible: false,
      builder: (alertContext) => CupertinoAlertDialog(
        title: Text(alertContext.s.error),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: Text(alertContext.s.ok),
            onPressed: () => Navigator.pop(alertContext),
          )
        ],
      ),
    );
  }
}
