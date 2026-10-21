import 'package:awsar_app/features/get_involved/domain/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('email', () {
    expect(validateEmail(''), FieldError.required);
    expect(validateEmail('a@b'), FieldError.email);
    expect(validateEmail('dhruv@example.com'), isNull);
  });

  test('Indian mobile accepts common formats and rejects others', () {
    for (final ok in ['9876543210', '+91 98765 43210', '09876543210', '91-9876543210']) {
      expect(validateIndianMobile(ok), isNull, reason: ok);
    }
    for (final bad in ['12345', '5876543210', '98765432101']) {
      expect(validateIndianMobile(bad), FieldError.phone, reason: bad);
    }
  });

  test('amount must be above zero', () {
    expect(validateAmount('0'), FieldError.amount);
    expect(validateAmount('-5'), FieldError.amount);
    expect(validateAmount('abc'), FieldError.amount);
    expect(validateAmount('1,000'), isNull);
  });

  test('PAN is optional but must match ABCDE1234F when given', () {
    expect(validatePanOptional(''), isNull);
    expect(validatePanOptional('abcde1234f'), isNull);
    expect(validatePanOptional('ABCDE12345'), FieldError.pan);
  });
}
