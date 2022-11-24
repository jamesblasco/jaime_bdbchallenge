// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotels_repository/hotels_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

void main() {
  group('HotelsRepository', () {
    test('can be instantiated', () {
      expect(HotelsRepository(MockFirestore()), isNotNull);
    });

    group('hotels', () {
      test('returns data', () async {
        final firestore = FakeFirebaseFirestore();
        await firestore.collection('hotels').add({
          'imageUrl': 'imageUrl',
          'name': 'name',
          'link': 'link',
          'blurhash': 'blurhash',
        });

        expect(
          HotelsRepository(firestore).hotels(),
          completion([
            Hotel(
              imageUrl: 'imageUrl',
              blurhash: 'blurhash',
              name: 'name',
              link: 'link',
            ),
          ]),
        );
      });

      test('throws HotelsFailure if error', () async {
        final FirebaseFirestore firestore = MockFirestore();
        when(() => firestore.collection(any()))
            .thenThrow(FirebaseException(plugin: 'plugin'));
        expect(
          HotelsRepository(firestore).hotels(),
          throwsA(isA<HotelsFailure>()),
        );
      });
    });
  });
}
