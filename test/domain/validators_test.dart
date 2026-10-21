import 'package:flutter_test/flutter_test.dart';
import 'package:onetick/core/failures.dart';
import 'package:onetick/domain/auth/usecases/auth_validators.dart';
import 'package:onetick/domain/focus/usecases/focus_title_validator.dart';

void main() {
  group('AuthValidators', () {
    test('email', () {
      expect(AuthValidators.email('  ana@onetick.dev '), 'ana@onetick.dev');
      expect(() => AuthValidators.email(''), throwsA(isA<AppFailure>()));
      expect(() => AuthValidators.email('ana@'), throwsA(isA<AppFailure>()));
      expect(
        () => AuthValidators.email('ana onetick.dev'),
        throwsA(isA<AppFailure>()),
      );
    });

    test('new password requires 8 chars', () {
      expect(AuthValidators.newPassword('12345678'), '12345678');
      expect(
        () => AuthValidators.newPassword('1234567'),
        throwsA(isA<AppFailure>()),
      );
    });

    test('login password only needs to be non-empty', () {
      expect(AuthValidators.loginPassword('x'), 'x');
      expect(
        () => AuthValidators.loginPassword(''),
        throwsA(isA<AppFailure>()),
      );
    });

    test('name is trimmed and required', () {
      expect(AuthValidators.name('  Ana '), 'Ana');
      expect(() => AuthValidators.name('   '), throwsA(isA<AppFailure>()));
    });
  });

  group('FocusTitleValidator', () {
    test('trims and accepts up to 60 chars', () {
      expect(FocusTitleValidator.validate('  Ler  '), 'Ler');
      expect(FocusTitleValidator.validate('a' * 60), 'a' * 60);
    });

    test('rejects empty and >60', () {
      expect(
        () => FocusTitleValidator.validate('   '),
        throwsA(isA<AppFailure>()),
      );
      expect(
        () => FocusTitleValidator.validate('a' * 61),
        throwsA(isA<AppFailure>()),
      );
    });
  });
}
