import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../shared/models/user.dart';
import '../../shared/models/ride.dart';
import '../../shared/models/driver.dart';
import '../../shared/models/location.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // Auth endpoints
  @POST('/auth/login')
  Future<User> login(@Body() Map<String, dynamic> loginData);

  @POST('/auth/logout')
  Future<void> logout();

  @GET('/auth/me')
  Future<User> getCurrentUser();

  // Ride endpoints
  @POST('/rides')
  Future<Ride> createRide(@Body() Map<String, dynamic> rideData);

  @GET('/rides/{id}')
  Future<Ride> getRide(@Path() String id);

  @GET('/rides')
  Future<List<Ride>> getUserRides();

  @PUT('/rides/{id}/cancel')
  Future<Ride> cancelRide(@Path() String id);

  @PUT('/rides/{id}/rate')
  Future<Ride> rateRide(@Path() String id, @Body() Map<String, dynamic> rating);

  // Driver endpoints
  @GET('/drivers/nearby')
  Future<List<Driver>> getNearbyDrivers(
    @Query('lat') double latitude,
    @Query('lng') double longitude,
    @Query('radius') double radius,
  );

  // Fare endpoints
  @POST('/fares/estimate')
  Future<FareEstimate> getFareEstimate(@Body() Map<String, dynamic> fareData);

  // Location endpoints
  @GET('/locations/search')
  Future<List<Location>> searchLocations(@Query('query') String query);

  @GET('/locations/favorites')
  Future<List<SavedLocation>> getFavoriteLocations();

  @POST('/locations/favorites')
  Future<SavedLocation> addFavoriteLocation(
    @Body() Map<String, dynamic> locationData,
  );

  @DELETE('/locations/favorites/{id}')
  Future<void> removeFavoriteLocation(@Path() String id);
}
