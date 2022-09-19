import 'package:flutter_base/src/common/extensions/build_context_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/cubits/auth_cubit/auth/auth_cubit.dart';

class AuthBody extends StatefulWidget {
  const AuthBody({Key? key}) : super(key: key);

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> {
  final textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
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
          return ElevatedButton(
            child: Text(context.s.login),
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: Text(context.s.enter_your_name),
                  content: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CupertinoTextField(
                      focusNode: FocusNode()..requestFocus(),
                      controller: textEditingController,
                      onSubmitted: (value) => _login(context),
                    ),
                  ),
                  actions: [
                    CupertinoDialogAction(
                        isDefaultAction: true,
                        onPressed: () => _login(context),
                        child: Text(context.s.confirm)),
                    CupertinoDialogAction(
                        onPressed: () => Navigator.pop(context),
                        child: Text(context.s.cancel))
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _login(BuildContext context) async {
    Navigator.of(context).pop();
    final name = textEditingController.text;
    if (name.isEmpty) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text(context.s.enter_your_name),
              ));
    } else {
      context.read<AuthCubit>().login(name);
    }
  }
}
