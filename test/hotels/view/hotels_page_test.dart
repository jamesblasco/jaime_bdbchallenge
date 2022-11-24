import 'package:bdb_challenge/hotels/hotels.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotels_repository/hotels_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../helpers/pump_app.dart';

class MockHotelsBloc extends MockBloc<HotelsEvent, HotelsState>
    implements HotelsBloc {}

void main() {
  group('HotelsPage', () {
    testWidgets('renders HotelsView', (tester) async {
      await tester.pumpApp(const HotelsPage());
      await tester.pumpAndSettle();
      expect(find.byType(HotelsView), findsOneWidget);
    });
  });

  group('HotelsView', () {
    late HotelsBloc hotelsBloc;

    setUp(() {
      hotelsBloc = MockHotelsBloc();
    });

    testWidgets('renders empty view initially', (tester) async {
      when(() => hotelsBloc.state).thenReturn(HotelsState());
      await tester.pumpApp(
        BlocProvider.value(
          value: hotelsBloc,
          child: const HotelsView(),
        ),
      );
      expect(find.byType(HotelView), findsNothing);
    });

    testWidgets('renders loading view when loading', (tester) async {
      when(() => hotelsBloc.state).thenReturn(
        HotelsState(status: HotelsStatus.loading),
      );

      await tester.pumpApp(
        BlocProvider.value(
          value: hotelsBloc,
          child: const HotelsView(),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders HotelView when data is ready', (tester) async {
      when(() => hotelsBloc.state).thenReturn(
        HotelsState(
          status: HotelsStatus.success,
          hotels: const [
            Hotel(
              imageUrl: 'imageUrl',
              blurhash: 'L5H2EC=PM+yV0g-mq.wG9c010J}I',
              name: 'name',
              link: 'link',
            )
          ],
        ),
      );
      await mockNetworkImages(() async {
        await tester.pumpApp(
          BlocProvider.value(
            value: hotelsBloc,
            child: const HotelsView(),
          ),
        );
        expect(find.byType(HotelView), findsOneWidget);
      });
    });

    testWidgets('renders error message when failure', (tester) async {
      when(() => hotelsBloc.state).thenReturn(
        HotelsState(status: HotelsStatus.failure),
      );

      await tester.pumpApp(
        BlocProvider.value(
          value: hotelsBloc,
          child: const HotelsView(),
        ),
      );
      expect(find.text('An error ocurred'), findsOneWidget);
    });
  });
}
