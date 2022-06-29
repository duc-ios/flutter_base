import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/locale_keys.g.dart';
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
            child: Text(LocaleKeys.login.tr()),
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: Text(LocaleKeys.enter_your_name.tr()),
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
                        child: Text(LocaleKeys.confirm.tr())),
                    CupertinoDialogAction(
                        onPressed: () => Navigator.pop(context),
                        child: Text(LocaleKeys.cancel.tr()))
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
                content: const Text(LocaleKeys.enter_your_name).tr(),
              ));
    } else {
      context.read<AuthCubit>().login(name);
    }
  }
}
