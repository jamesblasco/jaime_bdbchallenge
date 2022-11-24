import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:hotels_repository/hotels_repository.dart';

/// A widget that displays an image while video is loading
class HotelImagePreview extends StatelessWidget {
  const HotelImagePreview({super.key, required this.hotel});

  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: hotel.imageUrl,
      fadeInDuration: const Duration(milliseconds: 200),
      fit: BoxFit.cover,
      placeholder: (context, url) {
        return BlurHash(hash: hotel.blurhash);
      },
    );
  }
}
