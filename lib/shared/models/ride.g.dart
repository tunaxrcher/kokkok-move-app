// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RideImpl _$$RideImplFromJson(Map<String, dynamic> json) => _$RideImpl(
  id: json['id'] as String,
  pickupLocation: Location.fromJson(
    json['pickupLocation'] as Map<String, dynamic>,
  ),
  destination: Location.fromJson(json['destination'] as Map<String, dynamic>),
  status: $enumDecode(_$RideStatusEnumMap, json['status']),
  driver: json['driver'] == null
      ? null
      : Driver.fromJson(json['driver'] as Map<String, dynamic>),
  fare: (json['fare'] as num?)?.toDouble(),
  distance: (json['distance'] as num?)?.toDouble(),
  duration: (json['duration'] as num?)?.toInt(),
  estimatedArrival: (json['estimatedArrival'] as num?)?.toInt(),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  rating: (json['rating'] as num?)?.toDouble(),
  review: json['review'] as String?,
);

Map<String, dynamic> _$$RideImplToJson(_$RideImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pickupLocation': instance.pickupLocation,
      'destination': instance.destination,
      'status': _$RideStatusEnumMap[instance.status]!,
      'driver': instance.driver,
      'fare': instance.fare,
      'distance': instance.distance,
      'duration': instance.duration,
      'estimatedArrival': instance.estimatedArrival,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'rating': instance.rating,
      'review': instance.review,
    };

const _$RideStatusEnumMap = {
  RideStatus.searching: 'searching',
  RideStatus.driverAssigned: 'driver_assigned',
  RideStatus.driverOnWay: 'driver_on_way',
  RideStatus.driverArrived: 'driver_arrived',
  RideStatus.inTransit: 'in_transit',
  RideStatus.nearDestination: 'near_destination',
  RideStatus.completed: 'completed',
  RideStatus.cancelled: 'cancelled',
};

_$FareEstimateImpl _$$FareEstimateImplFromJson(Map<String, dynamic> json) =>
    _$FareEstimateImpl(
      baseFare: (json['baseFare'] as num).toDouble(),
      distanceFare: (json['distanceFare'] as num).toDouble(),
      timeFare: (json['timeFare'] as num).toDouble(),
      totalFare: (json['totalFare'] as num).toDouble(),
      distance: (json['distance'] as num).toDouble(),
      estimatedDuration: (json['estimatedDuration'] as num).toInt(),
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$$FareEstimateImplToJson(_$FareEstimateImpl instance) =>
    <String, dynamic>{
      'baseFare': instance.baseFare,
      'distanceFare': instance.distanceFare,
      'timeFare': instance.timeFare,
      'totalFare': instance.totalFare,
      'distance': instance.distance,
      'estimatedDuration': instance.estimatedDuration,
      'currency': instance.currency,
    };
