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
    return Consumer(builder: (context, ref, _) {
      final state = ref.watch(authProvider);
      ref.listen(
        authProvider,
        (_, current) => current.whenOrNull(
          error: (error) => error.whenOrNull(
            api: (error) => context.showApiError(error),
            other: (message) => context.showError(message),
          ),
        ),
      );
      return LoadingWidget(
        isLoading: state == const AuthState.loading(),
        child: Container(
          color: ColorName.background,
          child: Center(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 16.0,
                    children: [
                      Assets.images.welcome.image(),
                      EmailWidget(
                        emailTextEditingController: _emailTextEditingController,
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
                      Consumer(builder: (context, ref, _) {
                        return ElevatedButton(
                          child: Text(context.s.login),
                          onPressed: () => login(ref),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  void login(WidgetRef ref) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final email = _emailTextEditingController.text;
    final password = _passwordTextEditingController.text;
    ref
        .read(authProvider.bloc)
        .add(AuthEvent.login(LoginRequest(email: email, password: password)));
  }
}
