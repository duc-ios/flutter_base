import 'package:asuka/asuka.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/extensions/build_context_x.dart';
import '../../../../core/domain/errors/auth_error.dart';
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
      child: BlocBuilder<AuthCubit, AuthState>(
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
                    decoration: const InputDecoration(
                      hintText: 'e@ma.il',
                    ),
                  ),
                  TextField(
                    controller: _passwordTextEditingController,
                    decoration: const InputDecoration(
                      hintText: 'aA123456@',
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
    try {
      await context.read<AuthCubit>().login(email: email, password: password);
    } on AuthError catch (error) {
      error.when(
        invalidEmail: () {
          _showError(context.s.enter_valid_email);
        },
        invalidPassword: () => _showError(context.s.enter_valid_password),
      );
    } catch (error) {
      _showError(error.toString());
    }
  }

  void _showError(String message) {
    Asuka.showDialog(
      barrierDismissible: false,
      builder: (alertContext) => CupertinoAlertDialog(
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(alertContext),
          )
        ],
      ),
    );
  }
}
