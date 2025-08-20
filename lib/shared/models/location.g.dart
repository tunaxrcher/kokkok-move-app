// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationImpl _$$LocationImplFromJson(Map<String, dynamic> json) =>
    _$LocationImpl(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String?,
      name: json['name'] as String?,
      placeId: json['placeId'] as String?,
    );

Map<String, dynamic> _$$LocationImplToJson(_$LocationImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'name': instance.name,
      'placeId': instance.placeId,
    };

_$SavedLocationImpl _$$SavedLocationImplFromJson(Map<String, dynamic> json) =>
    _$SavedLocationImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      type: json['type'] as String? ?? 'custom',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$SavedLocationImplToJson(_$SavedLocationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'type': instance.type,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
