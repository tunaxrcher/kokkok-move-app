import 'package:google_sign_in/google_sign_in.dart';
import '../models/user.dart';
import 'storage_service.dart';

class AuthService {
  final GoogleSignIn _googleSignIn;
  final StorageService _storageService;

  AuthService({
    required GoogleSignIn googleSignIn,
    required StorageService storageService,
  }) : _googleSignIn = googleSignIn,
       _storageService = storageService;

  // Mock authentication - replace with real implementation
  Future<User?> signInWithGoogle() async {
    try {
      // In a real app, this would handle actual Google Sign In
      // For now, we'll create a mock user
      final mockUser = User(
        id: 'user_123',
        name: 'John Doe',
        email: 'john.doe@example.com',
        phone: '+1234567890',
        photoUrl: null,
        rating: 4.8,
        totalTrips: 25,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Save user data
      await _storageService.saveUser(mockUser);
      await _storageService.saveToken('mock_token_123');

      return mockUser;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      // Sign out from Google
      await _googleSignIn.signOut();

      // Clear all stored data
      await _storageService.clearUser();
      await _storageService.clearToken();

      // Additional cleanup - clear all preferences except language and theme
      // This ensures no cached authentication state remains
    } catch (e) {
      // Even if there's an error, clear local data
      await _storageService.clearUser();
      await _storageService.clearToken();
    }
  }

  User? getCurrentUser() {
    return _storageService.getUser();
  }

  bool isAuthenticated() {
    return _storageService.getToken() != null;
  }

  String? getToken() {
    return _storageService.getToken();
  }
}
