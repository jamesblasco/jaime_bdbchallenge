import 'package:bdb_challenge/hotels/hotels.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotels_repository/hotels_repository.dart';
import 'package:image_cache_manager/image_cache_manager.dart';
import 'package:mocktail/mocktail.dart';

class MockHotelsRepository extends Mock implements HotelsRepository {}

class MockImageCacheManager extends Mock implements ImageCacheManager {}

const hotels = [
  Hotel(imageUrl: 'imageUrl', blurhash: 'blurhash', name: 'name', link: 'link'),
  Hotel(
    imageUrl: 'imageUrl',
    blurhash: 'blurhash',
    name: 'name2',
    link: 'link',
  ),
];

void main() {
  group('HotelsBloc', () {
    late HotelsRepository hotelsRepository;
    late ImageCacheManager imageCacheManager;

    setUp(() {
      hotelsRepository = MockHotelsRepository();
      imageCacheManager = MockImageCacheManager();
      when(() => imageCacheManager.precacheImage(any()))
          .thenAnswer((invocation) async {});
    });
    test('initial state is HotelsState', () {
      expect(
        HotelsBloc(hotelsRepository, imageCacheManager).state,
        equals(const HotelsState()),
      );
    });

    blocTest<HotelsBloc, HotelsState>(
      'emits [loading] when starts searching',
      build: () => HotelsBloc(hotelsRepository, imageCacheManager),
      setUp: () {
        when(() => hotelsRepository.hotels()).thenAnswer((_) async => []);
      },
      act: (bloc) => bloc.add(HotelsFetched()),
      expect: () => contains(const HotelsState(status: HotelsStatus.loading)),
    );

    blocTest<HotelsBloc, HotelsState>(
      'emits [HotelsStatus.success] if succeeds',
      build: () => HotelsBloc(hotelsRepository, imageCacheManager),
      setUp: () {
        when(() => hotelsRepository.hotels()).thenAnswer((_) async => hotels);
      },
      act: (bloc) => bloc.add(HotelsFetched()),
      wait: const Duration(milliseconds: 200),
      expect: () => const [
        HotelsState(status: HotelsStatus.loading),
        HotelsState(status: HotelsStatus.success, hotels: hotels),
      ],
    );

    blocTest<HotelsBloc, HotelsState>(
      'precaches images if succeeds',
      build: () => HotelsBloc(hotelsRepository, imageCacheManager),
      setUp: () {
        when(() => hotelsRepository.hotels()).thenAnswer((_) async => hotels);
      },
      act: (bloc) => bloc.add(HotelsFetched()),
      wait: const Duration(milliseconds: 200),
      verify: (bloc) {
        verify(() => imageCacheManager.precacheImage(any())).called(2);
      },
    );

    blocTest<HotelsBloc, HotelsState>(
      'emits [HotelsStatus.failure] on failuter',
      build: () => HotelsBloc(hotelsRepository, imageCacheManager),
      setUp: () {
        when(() => hotelsRepository.hotels()).thenThrow(
          HotelsFailure('error', StackTrace.fromString('st')),
        );
      },
      act: (bloc) => bloc.add(HotelsFetched()),
      wait: const Duration(milliseconds: 200),
      expect: () => const [
        HotelsState(status: HotelsStatus.loading),
        HotelsState(status: HotelsStatus.failure),
      ],
    );
  });
}
