import 'package:flutter_test/flutter_test.dart';
import 'package:hotels_repository/hotels_repository.dart';

void main() {
  group('Hotel', () {
    test('supports equality', () {
      expect(
        const Hotel(
          imageUrl: 'imageUrl',
          blurhash: 'blurhash',
          name: 'name',
          link: 'link',
        ),
        equals(
          const Hotel(
            imageUrl: 'imageUrl',
            blurhash: 'blurhash',
            name: 'name',
            link: 'link',
          ),
        ),
      );
      expect(
        const Hotel(
          imageUrl: 'imageUrl',
          blurhash: 'blurhash',
          name: 'name',
          link: 'link',
        ),
        isNot(
          const Hotel(
            imageUrl: 'imageUrl',
            blurhash: 'blurhash',
            name: 'name2',
            link: 'link',
          ),
        ),
      );
    });
  });
}
