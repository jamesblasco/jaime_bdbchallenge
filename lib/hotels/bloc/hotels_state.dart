part of 'hotels_bloc.dart';

enum HotelsStatus { initial, loading, success, failure }

@immutable
class HotelsState extends Equatable {
  const HotelsState({
    this.status = HotelsStatus.initial,
    this.hotels = const [],
  });
  final HotelsStatus status;
  final List<Hotel> hotels;

  @override
  List<Object?> get props => [hotels, status];

  HotelsState copyWith({
    HotelsStatus? status,
    List<Hotel>? hotels,
    bool? muted,
  }) {
    return HotelsState(
      status: status ?? this.status,
      hotels: hotels ?? this.hotels,
    );
  }
}
