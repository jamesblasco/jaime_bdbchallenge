// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: prefer_const_constructors

import 'package:flutter_cache_manager/flutter_cache_manager.dart'
    hide ImageCacheManager;
import 'package:flutter_test/flutter_test.dart';
import 'package:image_cache_manager/image_cache_manager.dart';
import 'package:mocktail/mocktail.dart';

class MockCacheManager extends Mock implements CacheManager {}

class FakeFileInfo extends Fake implements FileInfo {}

void main() {
  late CacheManager cacheManager;

  setUp(() {
    cacheManager = MockCacheManager();
    when(() => cacheManager.downloadFile(any()))
        .thenAnswer((invocation) async => FakeFileInfo());
  });
  group('ImageCacheManager', () {
    test('can be instantiated', () {
      expect(ImageCacheManager(cacheManager), isNotNull);
    });

    test('can cache Images', () {
      expect(ImageCacheManager(cacheManager).precacheImage('url'), completes);
      verify(() => cacheManager.downloadFile(any())).called(1);
    });
  });
}
