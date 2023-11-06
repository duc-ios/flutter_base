part of '../pages/auth_page.dart';

class AuthBody extends StatefulWidget {
  const AuthBody({super.key});

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
    return Container(
      color: ColorName.background,
      child: Center(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            state.whenOrNull(
              error: (error) => error.whenOrNull(
                other: (message) => context.showError(message),
              ),
            );
          },
          builder: (context, state) {
            return Stack(alignment: Alignment.center, children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      runSpacing: 16.0,
                      children: [
                        Assets.images.welcome.image(),
                        EmailWidget(
                          emailTextEditingController:
                              _emailTextEditingController,
                          errorText: state.whenOrNull<String?>(
                            error: (error) => error.whenOrNull(
                              invalidEmail: () => context.s.error_invalid_email,
                            ),
                          ),
                        ),
                        PasswordWidget(
                          passwordTextEditingController:
                              _passwordTextEditingController,
                          errorText: state.whenOrNull<String?>(
                            error: (error) => error.whenOrNull(
                              invalidPassword: () =>
                                  context.s.error_invalid_password,
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
                ),
              ),
              if (state == const AuthState.loading())
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(child: CircularProgressIndicator()),
                )
            ]);
          },
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final email = _emailTextEditingController.text;
    final password = _passwordTextEditingController.text;
    await context
        .read<AuthCubit>()
        .login(LoginRequest(email: email, password: password));
  }
}
