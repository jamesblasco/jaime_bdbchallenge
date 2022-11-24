import 'package:bdb_challenge/hotels/hotels.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HotelsEvent', () {
    group('HotelsFetched', () {
      test('supports equality', () {
        expect(HotelsFetched(), HotelsFetched());
      });
    });
  });
}
