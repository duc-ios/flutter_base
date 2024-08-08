import 'package:flutter_base/src/common/utils/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isValidPassword', () {
    test('aA12345@ is a valid password', () {
      // given
      const password = 'aA12345@';

      // when
      final result = Validator.isValidPassword(password);

      // then
      expect(result, true);
    });

    test('123456 is not a valid password', () {
      // given
      const password = '12345';

      // when
      final result = Validator.isValidPassword(password);

      // then
      expect(result, false);
    });
  });

  group('isValidEmail', () {
    test('e@ma.il is a valid email', () {
      // given
      const email = 'e@ma.il';

      // when
      final result = Validator.isValidEmail(email);

      // then
      expect(result, true);
    });

    test('e@mail is not a valid email', () {
      // given
      const email = 'e@mail';

      // when
      final result = Validator.isValidEmail(email);

      // then
      expect(result, false);
    });
  });
  group('isValidUserName', () {
    test('abc is a valid username', () {
      // given
      const username = 'abc';

      // when
      final result = Validator.isValidUserName(username);

      // then
      expect(result, true);
    });

    test('a is not a valid username', () {
      // given
      const username = 'a';

      // when
      final result = Validator.isValidUserName(username);

      // then
      expect(result, false);
    });
  });
}
