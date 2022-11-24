import 'package:bdb_challenge/hotels/hotels.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HotelsState', () {
    test('has initial status', () {
      expect(HotelsState().status, HotelsStatus.initial);
    });
    test('supports equality', () {
      expect(HotelsState(), HotelsState().copyWith());
      expect(
        HotelsState(),
        isNot(HotelsState().copyWith(status: HotelsStatus.failure)),
      );
    });
  });
}
