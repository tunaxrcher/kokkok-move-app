import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../models/location.dart' as app_models;
import 'google_places_service.dart';

class LocationService {
  final GooglePlacesService _placesService = GooglePlacesService();
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

  Future<List<app_models.Location>> searchLocations(
    String query, {
    app_models.Location? currentLocation,
  }) async {
    if (query.isEmpty) return [];

    try {
      // Use Google Places Text Search for better results
      final results = await _placesService.textSearch(
        query,
        latitude: currentLocation?.latitude,
        longitude: currentLocation?.longitude,
      );

      if (results.isNotEmpty) {
        return results;
      }

      // Fallback to geocoding if Places API fails
      return await _fallbackGeocoding(query);
    } catch (e) {
      print('Search locations error: $e');
      // Fallback to geocoding
      return await _fallbackGeocoding(query);
    }
  }

  Future<List<app_models.Location>> _fallbackGeocoding(String query) async {
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
      print('Fallback geocoding error: $e');
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

  // Get place predictions for autocomplete
  Future<List<PlacePrediction>> getPlacePredictions(
    String query, {
    app_models.Location? currentLocation,
    String? sessionToken,
  }) async {
    if (query.isEmpty) return [];

    try {
      return await _placesService.getPlacePredictions(
        query,
        latitude: currentLocation?.latitude,
        longitude: currentLocation?.longitude,
        sessionToken: sessionToken,
      );
    } catch (e) {
      print('Get place predictions error: $e');
      return [];
    }
  }

  // Get place details from place ID
  Future<app_models.Location?> getPlaceDetails(String placeId) async {
    try {
      return await _placesService.getPlaceDetails(placeId);
    } catch (e) {
      print('Get place details error: $e');
      return null;
    }
  }

  // Get nearby places
  Future<List<app_models.Location>> getNearbyPlaces(
    app_models.Location location, {
    int radius = 5000, // 5km
    String type = 'establishment',
    String? keyword,
  }) async {
    try {
      return await _placesService.getNearbyPlaces(
        location.latitude,
        location.longitude,
        radius: radius,
        type: type,
        keyword: keyword,
      );
    } catch (e) {
      print('Get nearby places error: $e');
      return [];
    }
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
