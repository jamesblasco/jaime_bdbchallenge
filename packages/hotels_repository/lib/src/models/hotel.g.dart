// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hotel _$HotelFromJson(Map<String, dynamic> json) => Hotel(
      imageUrl: json['imageUrl'] as String,
      blurhash: json['blurhash'] as String,
      name: json['name'] as String,
      link: json['link'] as String,
    );

Map<String, dynamic> _$HotelToJson(Hotel instance) => <String, dynamic>{
      'name': instance.name,
      'link': instance.link,
      'imageUrl': instance.imageUrl,
      'blurhash': instance.blurhash,
    };
