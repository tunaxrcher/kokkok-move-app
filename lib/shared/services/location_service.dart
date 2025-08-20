import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../models/location.dart' as app_models;

class LocationService {
  Future<bool> requestPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  Future<app_models.Location?> getCurrentLocation() async {
    try {
      final hasPermission = await requestPermission();
      if (!hasPermission) return null;

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Get address from coordinates
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String? address;
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        address =
            '${placemark.street}, ${placemark.locality}, ${placemark.country}';
      }

      return app_models.Location(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
      );
    } catch (e) {
      return null;
    }
  }

  Future<List<app_models.Location>> searchLocations(String query) async {
    try {
      final locations = await locationFromAddress(query);
      final results = <app_models.Location>[];

      for (final location in locations) {
        final placemarks = await placemarkFromCoordinates(
          location.latitude,
          location.longitude,
        );

        String? address;
        if (placemarks.isNotEmpty) {
          final placemark = placemarks.first;
          address =
              '${placemark.street}, ${placemark.locality}, ${placemark.country}';
        }

        results.add(
          app_models.Location(
            latitude: location.latitude,
            longitude: location.longitude,
            address: address,
            name: query,
          ),
        );
      }

      return results;
    } catch (e) {
      // Return mock locations for demo
      return _getMockLocations(query);
    }
  }

  List<app_models.Location> _getMockLocations(String query) {
    return [
      app_models.Location(
        latitude: 13.7563,
        longitude: 100.5018,
        address: 'Bangkok, Thailand',
        name: 'Bangkok City Center',
      ),
      app_models.Location(
        latitude: 13.7650,
        longitude: 100.5380,
        address: 'Sukhumvit Road, Bangkok, Thailand',
        name: 'Sukhumvit',
      ),
      app_models.Location(
        latitude: 13.7460,
        longitude: 100.5340,
        address: 'Silom Road, Bangkok, Thailand',
        name: 'Silom',
      ),
    ];
  }

  double calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }
}
