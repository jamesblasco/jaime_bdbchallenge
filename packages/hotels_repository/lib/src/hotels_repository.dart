import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotels_repository/hotels_repository.dart';

/// {@template hotels_repository}
/// A repository that fetches the hotels from Firebase
/// {@endtemplate}
class HotelsRepository {
  /// {@macro hotels_repository}
  HotelsRepository(this._firestore);

  final FirebaseFirestore _firestore;

  Future<List<Hotel>> hotels() async {
    try {
      final hotelsRef = _firestore.collection('hotels');
      final snapshots = await hotelsRef.get();
      return snapshots.docs.map((e) => Hotel.fromJson(e.data())).toList();
    } catch (e, s) {
      throw HotelsFailure(e, s);
    }
  }
}
