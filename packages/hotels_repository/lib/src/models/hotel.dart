import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hotel.g.dart';

@JsonSerializable()
class Hotel extends Equatable {
  const Hotel({
    required this.imageUrl,
    required this.blurhash,
    required this.name,
    required this.link,
  });

  /// Converts the [Map] to [Hotel].
  factory Hotel.fromJson(Map<String, dynamic> json) {
    return _$HotelFromJson(json);
  }

  final String name;
  final String link;
  final String imageUrl;
  final String blurhash;

  @override
  List<Object?> get props => [name, link];

  /// Converts the [Hotel] to [Map].
  Map<String, dynamic> toJson() => _$HotelToJson(this);
}
