import 'package:freezed_annotation/freezed_annotation.dart';
import 'location.dart';

part 'driver.freezed.dart';
part 'driver.g.dart';

@freezed
class Driver with _$Driver {
  const factory Driver({
    required String id,
    required String name,
    required String phone,
    String? photoUrl,
    required Vehicle vehicle,
    @Default(4.5) double rating,
    @Default(0) int totalTrips,
    Location? currentLocation,
    @Default(0) int estimatedArrival, // in minutes
  }) = _Driver;

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);
}

@freezed
class Vehicle with _$Vehicle {
  const factory Vehicle({
    required String make,
    required String model,
    required String color,
    required String licensePlate,
    String? photoUrl,
    @Default('sedan') String type,
  }) = _Vehicle;

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);
}
