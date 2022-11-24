// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// {@template image_cache_manager}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class ImageCacheManager {
  /// {@macro image_cache_manager}
  const ImageCacheManager(this._cacheManager);

  final CacheManager _cacheManager;

  /// Precaches images before displaying
  Future<void> precacheImage(String url) async {
    await _cacheManager.downloadFile(url);
  }
}
