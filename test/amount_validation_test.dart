import 'package:flutter_test/flutter_test.dart';
import 'package:template/common/utils/validate.dart';

void main() {
  group('validateAmount', () {
    test('accepts Vietnamese thousands-formatted amount', () {
      expect(validateAmount('60.140'), isTrue);
      expect(validateAmount('30.000'), isTrue);
      expect(validateAmount('30000'), isTrue);
    });

    test('accepts decimal amount', () {
      expect(validateAmount('12.5'), isTrue);
      expect(validateAmount('12,5'), isTrue);
    });

    test('rejects invalid amount values', () {
      expect(validateAmount('0'), isFalse);
      expect(validateAmount('abc'), isFalse);
      expect(validateAmount('60.140,5'), isFalse);
    });
  });
}
