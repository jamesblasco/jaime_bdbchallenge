import 'package:bdb_challenge/hotels/hotels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotels_repository/hotels_repository.dart';
import 'package:image_cache_manager/image_cache_manager.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.hotelsRepository,
    required this.imageCacheManager,
  });

  final HotelsRepository hotelsRepository;
  final ImageCacheManager imageCacheManager;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => hotelsRepository,
        ),
        RepositoryProvider(
          create: (context) => imageCacheManager,
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beautiful Hotels',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HotelsPage(),
    );
  }
}
