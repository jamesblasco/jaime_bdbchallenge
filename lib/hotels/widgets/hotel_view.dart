import 'package:bdb_challenge/hotels/hotels.dart';
import 'package:flutter/material.dart';
import 'package:hotels_repository/hotels_repository.dart';
import 'package:video_player/video_player.dart';

class HotelView extends StatelessWidget {
  const HotelView({super.key, required this.hotel});

  final Hotel hotel;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        HotelVideo(
          create: () {
            return VideoPlayerController.network(hotel.link);
          },
          placeholder: HotelImagePreview(hotel: hotel),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: BottomGradientOverlay(
            child: SafeArea(
              child: Text(
                hotel.name,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BottomGradientOverlay extends StatelessWidget {
  const BottomGradientOverlay({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black54,
            Colors.black.withOpacity(0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      alignment: Alignment.bottomLeft,
      child: child,
    );
  }
}
