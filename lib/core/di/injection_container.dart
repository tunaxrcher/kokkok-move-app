import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../shared/services/auth_service.dart';
import '../../shared/services/location_service.dart';
import '../../shared/services/ride_service.dart';
import '../../shared/services/storage_service.dart';
import '../../shared/services/google_places_service.dart';
import '../network/api_client.dart';
import '../constants/app_constants.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Clear existing registrations to prevent errors during hot reload
  if (sl.isRegistered<SharedPreferences>()) {
    await sl.reset();
  }

  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  final googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  sl.registerSingleton<GoogleSignIn>(googleSignIn);

  // Dio
  sl.registerSingleton<Dio>(_createDio());

  // Core services
  sl.registerSingleton<ApiClient>(ApiClient(sl<Dio>()));
  sl.registerSingleton<StorageService>(StorageService(sl<SharedPreferences>()));

  // Feature services
  sl.registerSingleton<AuthService>(
    AuthService(
      googleSignIn: sl<GoogleSignIn>(),
      storageService: sl<StorageService>(),
    ),
  );

  sl.registerSingleton<GooglePlacesService>(GooglePlacesService());
  sl.registerSingleton<LocationService>(LocationService());

  sl.registerSingleton<RideService>(
    RideService(
      apiClient: sl<ApiClient>(),
      locationService: sl<LocationService>(),
    ),
  );
}

Dio _createDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: AppConstants.connectTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Add interceptors for logging, authentication, etc.
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: false,
    ),
  );

  return dio;
}
