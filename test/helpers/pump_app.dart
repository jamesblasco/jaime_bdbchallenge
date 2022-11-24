// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotels_repository/hotels_repository.dart';
import 'package:image_cache_manager/image_cache_manager.dart';
import 'package:mocktail/mocktail.dart';

class MockHotelsRepository extends Mock implements HotelsRepository {}

class MockImageCacheManager extends Mock implements ImageCacheManager {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    HotelsRepository? hotelsRepository,
    ImageCacheManager? cacheManager,
  }) {
    return pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: hotelsRepository ?? MockHotelsRepository(),
          ),
          RepositoryProvider.value(
            value: cacheManager ?? MockImageCacheManager(),
          ),
        ],
        child: MaterialApp(
          //   localizationsDelegates: AppLocalizations.localizationsDelegates,
          //   supportedLocales: AppLocalizations.supportedLocales,
          home: widget,
        ),
      ),
    );
  }
}
