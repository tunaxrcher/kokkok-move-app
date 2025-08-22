import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/location.dart' as app_models;
import '../../core/config/environment.dart';

class GooglePlacesService {
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api';

  // Get API key based on platform
  String get _apiKey {
    // For now, use web API key as it's configured
    return Environment.googleMapsApiKeyWeb;
  }

  // Place Autocomplete API
  Future<List<PlacePrediction>> getPlacePredictions(
    String query, {
    String? sessionToken,
    double? latitude,
    double? longitude,
    int radius = 50000, // 50km radius
    String? language = 'th',
    String? region = 'TH',
  }) async {
    if (query.isEmpty) return [];

    final uri = Uri.parse('$_baseUrl/place/autocomplete/json').replace(
      queryParameters: {
        'input': query,
        'key': _apiKey,
        'language': language,
        'region': region,
        'sessiontoken': sessionToken,
        if (latitude != null && longitude != null) ...{
          'location': '$latitude,$longitude',
          'radius': radius.toString(),
          'strictbounds': 'true',
        },
        'components': 'country:th', // Restrict to Thailand
      },
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          final predictions = data['predictions'] as List;
          return predictions
              .map((prediction) => PlacePrediction.fromJson(prediction))
              .toList();
        } else {
          print(
            'Places API Error: ${data['status']} - ${data['error_message']}',
          );
          return [];
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception in getPlacePredictions: $e');
      return [];
    }
  }

  // Place Details API
  Future<app_models.Location?> getPlaceDetails(String placeId) async {
    final uri = Uri.parse('$_baseUrl/place/details/json').replace(
      queryParameters: {
        'place_id': placeId,
        'key': _apiKey,
        'fields': 'name,formatted_address,geometry,place_id,types',
        'language': 'th',
      },
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          final result = data['result'];
          final geometry = result['geometry']['location'];

          return app_models.Location(
            latitude: geometry['lat'].toDouble(),
            longitude: geometry['lng'].toDouble(),
            name: result['name'],
            address: result['formatted_address'],
            placeId: result['place_id'],
          );
        } else {
          print(
            'Place Details API Error: ${data['status']} - ${data['error_message']}',
          );
          return null;
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception in getPlaceDetails: $e');
      return null;
    }
  }

  // Nearby Search API
  Future<List<app_models.Location>> getNearbyPlaces(
    double latitude,
    double longitude, {
    int radius = 5000, // 5km radius
    String type = 'establishment',
    String? keyword,
    String? language = 'th',
  }) async {
    final uri = Uri.parse('$_baseUrl/place/nearbysearch/json').replace(
      queryParameters: {
        'location': '$latitude,$longitude',
        'radius': radius.toString(),
        'type': type,
        'key': _apiKey,
        'language': language,
        if (keyword != null) 'keyword': keyword,
      },
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          final results = data['results'] as List;
          return results.map((place) {
            final geometry = place['geometry']['location'];
            return app_models.Location(
              latitude: geometry['lat'].toDouble(),
              longitude: geometry['lng'].toDouble(),
              name: place['name'],
              address: place['vicinity'] ?? place['formatted_address'],
              placeId: place['place_id'],
            );
          }).toList();
        } else {
          print(
            'Nearby Search API Error: ${data['status']} - ${data['error_message']}',
          );
          return [];
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception in getNearbyPlaces: $e');
      return [];
    }
  }

  // Text Search API (alternative to autocomplete for broader searches)
  Future<List<app_models.Location>> textSearch(
    String query, {
    double? latitude,
    double? longitude,
    int radius = 50000,
    String? language = 'th',
    String? region = 'TH',
  }) async {
    if (query.isEmpty) return [];

    final uri = Uri.parse('$_baseUrl/place/textsearch/json').replace(
      queryParameters: {
        'query': query,
        'key': _apiKey,
        'language': language,
        'region': region,
        if (latitude != null && longitude != null) ...{
          'location': '$latitude,$longitude',
          'radius': radius.toString(),
        },
      },
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          final results = data['results'] as List;
          return results.map((place) {
            final geometry = place['geometry']['location'];
            return app_models.Location(
              latitude: geometry['lat'].toDouble(),
              longitude: geometry['lng'].toDouble(),
              name: place['name'],
              address: place['formatted_address'],
              placeId: place['place_id'],
            );
          }).toList();
        } else {
          print(
            'Text Search API Error: ${data['status']} - ${data['error_message']}',
          );
          return [];
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception in textSearch: $e');
      return [];
    }
  }
}

// Model for Place Prediction (Autocomplete)
class PlacePrediction {
  final String placeId;
  final String description;
  final String? mainText;
  final String? secondaryText;
  final List<String> types;

  PlacePrediction({
    required this.placeId,
    required this.description,
    this.mainText,
    this.secondaryText,
    required this.types,
  });

  factory PlacePrediction.fromJson(Map<String, dynamic> json) {
    final structuredFormatting = json['structured_formatting'];

    return PlacePrediction(
      placeId: json['place_id'],
      description: json['description'],
      mainText: structuredFormatting?['main_text'],
      secondaryText: structuredFormatting?['secondary_text'],
      types: List<String>.from(json['types'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place_id': placeId,
      'description': description,
      'main_text': mainText,
      'secondary_text': secondaryText,
      'types': types,
    };
  }
}
