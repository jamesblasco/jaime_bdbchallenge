import 'package:bdb_challenge/hotels/hotels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:video_player/video_player.dart';

import '../../helpers/pump_app.dart';

class MockVideoPlayerController extends Mock implements VideoPlayerController {}

void main() {
  late VideoPlayerController controller;

  setUp(() {
    controller = MockVideoPlayerController();
    when(() => controller.initialize()).thenAnswer((invocation) async {});
    when(() => controller.setLooping(any())).thenAnswer((invocation) async {});
    when(() => controller.play()).thenAnswer((invocation) async {});
    when(() => controller.dispose()).thenAnswer((invocation) async {});
    when(() => controller.value).thenReturn(
      VideoPlayerValue(duration: Duration.zero),
    );
  });
  group('HotelVideo', () {
    testWidgets('renders empty view by default', (tester) async {
      await tester.pumpApp(HotelVideo(create: () => controller));
      await tester.pumpAndSettle();
      expect(find.byType(VideoPlayer), findsNothing);
    });

    testWidgets('renders placeholder', (tester) async {
      await tester.pumpApp(
        HotelVideo(
          create: () => controller,
          placeholder: Text('placeholder'),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('placeholder'), findsOneWidget);
    });

    testWidgets('calls initialize on Init', (tester) async {
      await tester.pumpApp(HotelVideo(create: () => controller));
      verify(() => controller.initialize()).called(1);
    });
    testWidgets('sets looping on Init', (tester) async {
      await tester.pumpApp(HotelVideo(create: () => controller));
      verify(() => controller.setLooping(true)).called(1);
    });

    testWidgets('autoplay on Init', (tester) async {
      await tester.pumpApp(HotelVideo(create: () => controller));
      verify(() => controller.play()).called(1);
    });

    testWidgets('renders video if initialized on Init', (tester) async {
      when(() => controller.value).thenReturn(
        VideoPlayerValue(
          duration: Duration.zero,
          isInitialized: true,
        ),
      );
      when(() => controller.textureId).thenReturn(0);
      await tester.pumpApp(HotelVideo(create: () => controller));
      expect(find.byType(VideoPlayer), findsOneWidget);
    });
  });
}
