import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/main_page.dart';
import '../../features/home/presentation/pages/ride_tracking_page.dart';
import '../../features/home/presentation/pages/test_map_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/profile/presentation/pages/language_page.dart';
import '../../features/profile/presentation/pages/activity_page.dart';
import '../../features/profile/presentation/pages/favorites_page.dart';
import '../../features/profile/presentation/pages/notice_page.dart';
import '../../features/profile/presentation/pages/help_center_page.dart';
import '../../features/profile/presentation/pages/settings_page.dart';
import '../../features/profile/presentation/pages/green_dashboard_page.dart';
import '../../features/profile/presentation/pages/my_pages.dart';
import '../../features/history/presentation/pages/history_page.dart';
import '../../features/contact/presentation/pages/contact_page.dart';
import '../../shared/services/auth_service.dart';
import '../di/injection_container.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    routes: [
      // Auth routes
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),

      // Test map route
      GoRoute(
        path: '/test-map',
        builder: (context, state) => const TestMapPage(),
      ),

      // Main app with bottom navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainPage(child: child),
        routes: [
          GoRoute(
            path: '/my-pages',
            builder: (context, state) => const MyPagesPage(),
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) =>
                const SizedBox(), // Home content is in MainPage
          ),
          GoRoute(
            path: '/history',
            builder: (context, state) => const HistoryPage(),
          ),
          GoRoute(
            path: '/contact',
            builder: (context, state) => const ContactPage(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),

      // Ride tracking (full screen)
      GoRoute(
        path: '/ride/:rideId',
        builder: (context, state) {
          final rideId = state.pathParameters['rideId']!;
          return RideTrackingPage(rideId: rideId);
        },
      ),

      // My Pages route
      GoRoute(
        path: '/my-pages',
        builder: (context, state) => const MyPagesPage(),
      ),

      // Profile routes
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
        routes: [
          GoRoute(
            path: 'edit',
            builder: (context, state) => const EditProfilePage(),
          ),
          GoRoute(
            path: 'language',
            builder: (context, state) => const LanguagePage(),
          ),
          GoRoute(
            path: 'activity',
            builder: (context, state) => const ActivityPage(),
          ),
          GoRoute(
            path: 'favorites',
            builder: (context, state) => const FavoritesPage(),
          ),
          GoRoute(
            path: 'notice',
            builder: (context, state) => const NoticePage(),
          ),
          GoRoute(
            path: 'help',
            builder: (context, state) => const HelpCenterPage(),
          ),
          GoRoute(
            path: 'green-dashboard',
            builder: (context, state) => const GreenDashboardPage(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final authService = sl<AuthService>();
      final isAuthenticated = authService.isAuthenticated();
      final currentPath = state.uri.toString();
      final isLoginPage = currentPath == '/login';
      final isTestMapPage = currentPath == '/test-map';

      // Debug logging (remove in production)
      print(
        'Router redirect: path=$currentPath, authenticated=$isAuthenticated',
      );

      // Allow test map page without authentication
      if (isTestMapPage) {
        return null;
      }

      // If not authenticated and not on login page, redirect to login
      if (!isAuthenticated && !isLoginPage) {
        print('Redirecting to login: user not authenticated');
        return '/login';
      }

      // If authenticated and on login page, redirect to home
      if (isAuthenticated && isLoginPage) {
        print('Redirecting to home: user already authenticated');
        return '/home';
      }

      return null;
    },
  );
}

// Route names for easy navigation
class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String history = '/history';
  static const String contact = '/contact';
  static const String settings = '/settings';
  static const String myPages = '/my-pages';
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String language = '/profile/language';
  static const String activity = '/profile/activity';
  static const String favorites = '/profile/favorites';
  static const String notice = '/profile/notice';
  static const String helpCenter = '/profile/help';
  static const String greenDashboard = '/profile/green-dashboard';

  static String rideTracking(String rideId) => '/ride/$rideId';
}
