part of '../pages/auth_page.dart';

class PasswordWidget extends StatefulWidget {
  const PasswordWidget({
    super.key,
    required TextEditingController passwordTextEditingController,
    required String? errorText,
  })  : _passwordTextEditingController = passwordTextEditingController,
        _errorText = errorText;

  final TextEditingController _passwordTextEditingController;
  final String? _errorText;

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: !_passwordVisible,
      controller: widget._passwordTextEditingController,
      decoration: InputDecoration(
        label: Text(context.s.password),
        hintText: 'aA12345@',
        errorText: widget._errorText,
        errorMaxLines: 2,
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
  }
}
