import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kokkok_move/shared/services/auth_service.dart';
import 'package:kokkok_move/shared/services/storage_service.dart';

import 'auth_service_test.mocks.dart';

@GenerateMocks([GoogleSignIn, SharedPreferences])
void main() {
  group('AuthService', () {
    late AuthService authService;
    late MockGoogleSignIn mockGoogleSignIn;
    late MockSharedPreferences mockSharedPreferences;
    late StorageService storageService;

    setUp(() {
      mockGoogleSignIn = MockGoogleSignIn();
      mockSharedPreferences = MockSharedPreferences();
      storageService = StorageService(mockSharedPreferences);
      authService = AuthService(
        googleSignIn: mockGoogleSignIn,
        storageService: storageService,
      );
    });

    test('should return mock user when signInWithGoogle is called', () async {
      // Act
      final result = await authService.signInWithGoogle();

      // Assert
      expect(result, isNotNull);
      expect(result!.name, equals('John Doe'));
      expect(result.email, equals('john.doe@example.com'));
    });

    test('should return true when user is authenticated', () async {
      // Arrange
      when(
        mockSharedPreferences.getString('user_token'),
      ).thenReturn('mock_token');

      // Act
      final result = authService.isAuthenticated();

      // Assert
      expect(result, isTrue);
    });

    test('should return false when user is not authenticated', () async {
      // Arrange
      when(mockSharedPreferences.getString('user_token')).thenReturn(null);

      // Act
      final result = authService.isAuthenticated();

      // Assert
      expect(result, isFalse);
    });

    test('should clear user data when signOut is called', () async {
      // Act
      await authService.signOut();

      // Assert
      verify(mockGoogleSignIn.signOut()).called(1);
    });
  });
}
