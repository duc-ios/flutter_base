class Validator {
  Validator._();

  static bool isValidPassword(String password) => password.length >= 6;

  static bool isValidEmail(String email) {
    const emailRegExpString = r'[a-zA-Z0-9\+\.\_\%\-\+]{1,256}\@[a-zA-Z0-9]'
        r'[a-zA-Z0-9\-]{0,64}(\.[a-zA-Z0-9][a-zA-Z0-9\-]{0,25})+';
    final emailRegex = RegExp(emailRegExpString, caseSensitive: false);
    return emailRegex.hasMatch(email);
  }

  static bool isValidUserName(String userName) => userName.length >= 3;
}
