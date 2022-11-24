import 'package:flutter_test/flutter_test.dart';
import 'package:hotels_repository/hotels_repository.dart';

void main() {
  group('HotelsFailure', () {
    test('supports equality', () {
      final stackTrace = StackTrace.fromString('stackTrace');
      expect(
        HotelsFailure('error', stackTrace),
        equals(HotelsFailure('error', stackTrace)),
      );
      expect(
        HotelsFailure('error', stackTrace),
        isNot(HotelsFailure('error2', stackTrace)),
      );
    });
  });
}
