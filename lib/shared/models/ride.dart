import 'package:freezed_annotation/freezed_annotation.dart';
import 'location.dart';
import 'driver.dart';

part 'ride.freezed.dart';
part 'ride.g.dart';

enum RideStatus {
  @JsonValue('searching')
  searching,
  @JsonValue('driver_assigned')
  driverAssigned,
  @JsonValue('driver_on_way')
  driverOnWay,
  @JsonValue('driver_arrived')
  driverArrived,
  @JsonValue('in_transit')
  inTransit,
  @JsonValue('near_destination')
  nearDestination,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}

@freezed
class Ride with _$Ride {
  const factory Ride({
    required String id,
    required Location pickupLocation,
    required Location destination,
    required RideStatus status,
    Driver? driver,
    double? fare,
    double? distance,
    int? duration, // in minutes
    int? estimatedArrival, // in minutes
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
    double? rating,
    String? review,
  }) = _Ride;

  factory Ride.fromJson(Map<String, dynamic> json) => _$RideFromJson(json);
}

@freezed
class FareEstimate with _$FareEstimate {
  const factory FareEstimate({
    required double baseFare,
    required double distanceFare,
    required double timeFare,
    required double totalFare,
    required double distance,
    required int estimatedDuration,
    String? currency,
  }) = _FareEstimate;

  factory FareEstimate.fromJson(Map<String, dynamic> json) =>
      _$FareEstimateFromJson(json);
}
