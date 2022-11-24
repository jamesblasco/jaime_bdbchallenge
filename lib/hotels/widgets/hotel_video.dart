import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

typedef VideoControllerFactory = VideoPlayerController Function();

class HotelVideo extends StatefulWidget {
  const HotelVideo({
    super.key,
    required this.create,
    this.placeholder,
  });
  final VideoControllerFactory create;

  final Widget? placeholder;

  @override
  State<HotelVideo> createState() => _HotelVideoState();
}

class _HotelVideoState extends State<HotelVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    initializeVideo();
  }

  Future<void> initializeVideo() async {
    _controller = widget.create();
    await _controller.initialize();
    await _controller.setLooping(true);
    await _controller.play();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.easeOutExpo,
      duration: const Duration(milliseconds: 200),
      child: _controller.value.isInitialized
          ? VideoPlayer(_controller)
          : SizedBox.expand(
              child: widget.placeholder ?? const SizedBox(),
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
