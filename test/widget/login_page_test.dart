import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kokkok_move/features/auth/presentation/pages/login_page.dart';
import 'package:kokkok_move/core/theme/app_theme.dart';

void main() {
  group('LoginPage Widget Tests', () {
    testWidgets('should display app name and sign in button', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.darkTheme,
            home: const LoginPage(),
          ),
        ),
      );

      // Assert
      expect(find.text('KOKKOK Move'), findsOneWidget);
      expect(find.text('Sign in with Google'), findsOneWidget);
      expect(find.byIcon(Icons.local_taxi), findsOneWidget);
    });

    testWidgets('should show loading state when button is pressed', (
      tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.darkTheme,
            home: const LoginPage(),
          ),
        ),
      );

      // Act
      await tester.tap(find.text('Sign in with Google'));
      await tester.pump();

      // Assert
      expect(find.text('Signing in...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
