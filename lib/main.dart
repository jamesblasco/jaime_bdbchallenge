import 'package:bdb_challenge/app/app.dart';
import 'package:bdb_challenge/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hotels_repository/hotels_repository.dart';
import 'package:image_cache_manager/image_cache_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firestore = FirebaseFirestore.instance;
  final hotelsRepository = HotelsRepository(firestore);
  final imageCacheManager = ImageCacheManager(DefaultCacheManager());
  runApp(
    App(
      hotelsRepository: hotelsRepository,
      imageCacheManager: imageCacheManager,
    ),
  );
}
