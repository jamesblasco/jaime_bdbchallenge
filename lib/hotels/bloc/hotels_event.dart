part of 'hotels_bloc.dart';

@immutable
abstract class HotelsEvent extends Equatable {}

class HotelsFetched extends HotelsEvent {
  @override
  List<Object?> get props => [];
}
