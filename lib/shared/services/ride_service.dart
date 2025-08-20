import 'dart:async';
import 'dart:math';
import '../models/ride.dart';
import '../models/driver.dart';
import '../models/location.dart';
import '../../core/network/api_client.dart';
import 'location_service.dart';

class RideService {
  // final ApiClient _apiClient; // Will be used when connecting to real API
  final LocationService _locationService;
  final List<Ride> _rideHistory = [];

  RideService({
    required ApiClient apiClient,
    required LocationService locationService,
  }) : // _apiClient = apiClient, // Will be used when connecting to real API
       _locationService = locationService;

  Future<FareEstimate> getFareEstimate(
    Location pickup,
    Location destination,
  ) async {
    try {
      // In production, this would call the API
      // For now, return mock data
      final distance =
          _locationService.calculateDistance(
            pickup.latitude,
            pickup.longitude,
            destination.latitude,
            destination.longitude,
          ) /
          1000; // Convert to km

      final baseFare = 40.0;
      final distanceFare = distance * 12.0;
      final timeFare = 15.0; // Mock time fare
      final totalFare = baseFare + distanceFare + timeFare;

      return FareEstimate(
        baseFare: baseFare,
        distanceFare: distanceFare,
        timeFare: timeFare,
        totalFare: totalFare,
        distance: distance,
        estimatedDuration: (distance * 2).round(), // Mock: 2 minutes per km
        currency: 'THB',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Ride> bookRide(Location pickup, Location destination) async {
    try {
      final ride = Ride(
        id: 'ride_${DateTime.now().millisecondsSinceEpoch}',
        pickupLocation: pickup,
        destination: destination,
        status: RideStatus.searching,
        createdAt: DateTime.now(),
      );

      return ride;
    } catch (e) {
      rethrow;
    }
  }

  Stream<Ride> trackRide(String rideId) async* {
    // Mock ride tracking with status updates
    final ride = _getMockRide(rideId);
    yield ride;

    // Simulate ride progress
    await Future.delayed(const Duration(seconds: 3));
    yield ride.copyWith(
      status: RideStatus.driverAssigned,
      driver: _getMockDriver(),
      estimatedArrival: 8,
    );

    await Future.delayed(const Duration(seconds: 5));
    yield ride.copyWith(status: RideStatus.driverOnWay, estimatedArrival: 5);

    await Future.delayed(const Duration(seconds: 8));
    yield ride.copyWith(status: RideStatus.driverArrived, estimatedArrival: 0);

    await Future.delayed(const Duration(seconds: 3));
    yield ride.copyWith(status: RideStatus.inTransit);

    await Future.delayed(const Duration(seconds: 10));
    yield ride.copyWith(status: RideStatus.nearDestination);

    await Future.delayed(const Duration(seconds: 5));
    final completedRide = ride.copyWith(
      status: RideStatus.completed,
      fare: 125.0,
      distance: 8.5,
      duration: 15,
      completedAt: DateTime.now(),
    );

    _rideHistory.add(completedRide);
    yield completedRide;
  }

  Future<Ride> rateRide(String rideId, double rating, String? review) async {
    try {
      // In production, this would call the API
      final rideIndex = _rideHistory.indexWhere((ride) => ride.id == rideId);
      if (rideIndex != -1) {
        _rideHistory[rideIndex] = _rideHistory[rideIndex].copyWith(
          rating: rating,
          review: review,
        );
        return _rideHistory[rideIndex];
      }
      throw Exception('Ride not found');
    } catch (e) {
      rethrow;
    }
  }

  List<Ride> getRideHistory() {
    // Add some mock history if empty
    if (_rideHistory.isEmpty) {
      _rideHistory.addAll(_getMockRideHistory());
    }
    return List.from(_rideHistory.reversed);
  }

  Ride _getMockRide(String rideId) {
    return Ride(
      id: rideId,
      pickupLocation: const Location(
        latitude: 13.7563,
        longitude: 100.5018,
        address: 'Bangkok, Thailand',
        name: 'Current Location',
      ),
      destination: const Location(
        latitude: 13.7650,
        longitude: 100.5380,
        address: 'Sukhumvit Road, Bangkok, Thailand',
        name: 'Sukhumvit',
      ),
      status: RideStatus.searching,
      createdAt: DateTime.now(),
    );
  }

  Driver _getMockDriver() {
    final random = Random();
    final drivers = [
      Driver(
        id: 'driver_1',
        name: 'Somchai Jaidee',
        phone: '+66812345678',
        photoUrl: null,
        vehicle: const Vehicle(
          make: 'Toyota',
          model: 'Camry',
          color: 'Silver',
          licensePlate: 'กก 1234',
          type: 'sedan',
        ),
        rating: 4.8,
        totalTrips: 1250,
        estimatedArrival: 8,
      ),
      Driver(
        id: 'driver_2',
        name: 'Niran Suksan',
        phone: '+66887654321',
        photoUrl: null,
        vehicle: const Vehicle(
          make: 'Honda',
          model: 'Civic',
          color: 'Black',
          licensePlate: 'ขข 5678',
          type: 'sedan',
        ),
        rating: 4.9,
        totalTrips: 980,
        estimatedArrival: 5,
      ),
    ];

    return drivers[random.nextInt(drivers.length)];
  }

  List<Ride> _getMockRideHistory() {
    return [
      Ride(
        id: 'ride_history_1',
        pickupLocation: const Location(
          latitude: 13.7563,
          longitude: 100.5018,
          address: 'Siam Square, Bangkok',
          name: 'Siam Square',
        ),
        destination: const Location(
          latitude: 13.7650,
          longitude: 100.5380,
          address: 'Terminal 21, Bangkok',
          name: 'Terminal 21',
        ),
        status: RideStatus.completed,
        driver: const Driver(
          id: 'driver_1',
          name: 'Somchai Jaidee',
          phone: '+66812345678',
          vehicle: Vehicle(
            make: 'Toyota',
            model: 'Camry',
            color: 'Silver',
            licensePlate: 'กก 1234',
            type: 'sedan',
          ),
          rating: 4.8,
          totalTrips: 1250,
        ),
        fare: 95.0,
        distance: 6.2,
        duration: 12,
        rating: 5.0,
        review: 'Great driver, very polite!',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        completedAt: DateTime.now().subtract(
          const Duration(days: 2, hours: -1),
        ),
      ),
      Ride(
        id: 'ride_history_2',
        pickupLocation: const Location(
          latitude: 13.7460,
          longitude: 100.5340,
          address: 'Silom Road, Bangkok',
          name: 'Silom',
        ),
        destination: const Location(
          latitude: 13.7200,
          longitude: 100.5170,
          address: 'Chatuchak Market, Bangkok',
          name: 'Chatuchak',
        ),
        status: RideStatus.completed,
        driver: const Driver(
          id: 'driver_2',
          name: 'Niran Suksan',
          phone: '+66887654321',
          vehicle: Vehicle(
            make: 'Honda',
            model: 'Civic',
            color: 'Black',
            licensePlate: 'ขข 5678',
            type: 'sedan',
          ),
          rating: 4.9,
          totalTrips: 980,
        ),
        fare: 140.0,
        distance: 11.5,
        duration: 18,
        rating: 4.0,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        completedAt: DateTime.now().subtract(
          const Duration(days: 5, hours: -1),
        ),
      ),
    ];
  }
}
