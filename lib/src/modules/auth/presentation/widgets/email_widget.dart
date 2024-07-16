part of '../pages/auth_page.dart';

class EmailWidget extends StatelessWidget {
  const EmailWidget({
    super.key,
    required TextEditingController emailTextEditingController,
    required String? errorText,
  })  : _emailTextEditingController = emailTextEditingController,
        _errorText = errorText;

  final TextEditingController _emailTextEditingController;
  final String? _errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _emailTextEditingController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        label: Text(context.s.email),
        hintText: 'example@domain.com',
        errorText: _errorText,
        errorMaxLines: 2,
      ),
    );
  }
}
