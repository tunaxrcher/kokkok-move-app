// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DriverImpl _$$DriverImplFromJson(Map<String, dynamic> json) => _$DriverImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  phone: json['phone'] as String,
  photoUrl: json['photoUrl'] as String?,
  vehicle: Vehicle.fromJson(json['vehicle'] as Map<String, dynamic>),
  rating: (json['rating'] as num?)?.toDouble() ?? 4.5,
  totalTrips: (json['totalTrips'] as num?)?.toInt() ?? 0,
  currentLocation: json['currentLocation'] == null
      ? null
      : Location.fromJson(json['currentLocation'] as Map<String, dynamic>),
  estimatedArrival: (json['estimatedArrival'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$DriverImplToJson(_$DriverImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'photoUrl': instance.photoUrl,
      'vehicle': instance.vehicle,
      'rating': instance.rating,
      'totalTrips': instance.totalTrips,
      'currentLocation': instance.currentLocation,
      'estimatedArrival': instance.estimatedArrival,
    };

_$VehicleImpl _$$VehicleImplFromJson(Map<String, dynamic> json) =>
    _$VehicleImpl(
      make: json['make'] as String,
      model: json['model'] as String,
      color: json['color'] as String,
      licensePlate: json['licensePlate'] as String,
      photoUrl: json['photoUrl'] as String?,
      type: json['type'] as String? ?? 'sedan',
    );

Map<String, dynamic> _$$VehicleImplToJson(_$VehicleImpl instance) =>
    <String, dynamic>{
      'make': instance.make,
      'model': instance.model,
      'color': instance.color,
      'licensePlate': instance.licensePlate,
      'photoUrl': instance.photoUrl,
      'type': instance.type,
    };
