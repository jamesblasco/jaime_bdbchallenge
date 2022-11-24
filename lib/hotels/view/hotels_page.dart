import 'package:bdb_challenge/hotels/hotels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotels_repository/hotels_repository.dart';
import 'package:image_cache_manager/image_cache_manager.dart';

class HotelsPage extends StatelessWidget {
  const HotelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HotelsBloc(
          context.read<HotelsRepository>(),
          context.read<ImageCacheManager>(),
        )..add(HotelsFetched());
      },
      child: const HotelsView(),
    );
  }
}

class HotelsView extends StatelessWidget {
  const HotelsView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HotelsBloc>().state;
    final hotels = state.hotels;
    Widget body;
    switch (state.status) {
      case HotelsStatus.initial:
        body = const SizedBox();
        break;
      case HotelsStatus.loading:
        body = const CircularProgressIndicator.adaptive();
        break;
      case HotelsStatus.success:
        body = PageView.builder(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return HotelView(hotel: hotels[index]);
          },
          itemCount: hotels.length,
        );
        break;
      case HotelsStatus.failure:
        body = const Center(
          child: Text('An error ocurred'),
        );
        break;
    }

    return Scaffold(
      body: body,
    );
  }
}
