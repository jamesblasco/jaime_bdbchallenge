import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hotels_repository/hotels_repository.dart';
import 'package:image_cache_manager/image_cache_manager.dart';

part 'hotels_event.dart';
part 'hotels_state.dart';

class HotelsBloc extends Bloc<HotelsEvent, HotelsState> {
  HotelsBloc(
    this._hotelsRepository,
    this._imageCacheManager,
  ) : super(const HotelsState()) {
    on<HotelsFetched>(_onFetched);
  }

  final HotelsRepository _hotelsRepository;
  final ImageCacheManager _imageCacheManager;

  Future<void> _onFetched(
    HotelsFetched event,
    Emitter<HotelsState> emit,
  ) async {
    emit(state.copyWith(status: HotelsStatus.loading));
    try {
      final hotels = await _hotelsRepository.hotels();
      emit(state.copyWith(status: HotelsStatus.success, hotels: hotels));
      await cachePreviewImages(hotels);
    } catch (e) {
      emit(state.copyWith(status: HotelsStatus.failure));
    }
  }

  Future<void> cachePreviewImages(List<Hotel> hotels) async {
    await Future.wait([
      for (final hotel in hotels)
        _imageCacheManager.precacheImage(hotel.imageUrl),
    ]);
  }
}
