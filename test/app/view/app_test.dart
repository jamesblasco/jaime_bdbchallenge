// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bdb_challenge/app/app.dart';
import 'package:bdb_challenge/hotels/hotels.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../hotels/bloc/hotels_bloc_test.dart';

void main() {
  group('App', () {
    testWidgets('renders HotelsPage', (tester) async {
      await tester.pumpWidget(
        App(
          hotelsRepository: MockHotelsRepository(),
          imageCacheManager: MockImageCacheManager(),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(HotelsPage), findsOneWidget);
    });
  });
}
