import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/services/auth_service.dart';
import '../../../../core/di/injection_container.dart';

class MyPagesPage extends StatelessWidget {
  const MyPagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = sl<AuthService>();
    final user = authService.getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Pages'),
        backgroundColor: AppColors.surface,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with logo and user info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppConstants.spacing24),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(AppConstants.radiusXLarge),
                ),
              ),
              child: Column(
                children: [
                  // EV-X Logo
                  Container(
                    width: 200,
                    height: 60,
                    padding: const EdgeInsets.all(AppConstants.spacing8),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(
                        AppConstants.radiusLarge,
                      ),
                    ),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 180,
                      height: 44,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacing16),

                  // User info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        backgroundImage: user?.photoUrl != null
                            ? NetworkImage(user!.photoUrl!)
                            : null,
                        child: user?.photoUrl == null
                            ? const Icon(
                                Icons.person,
                                size: 30,
                                color: AppColors.primary,
                              )
                            : null,
                      ),
                      const SizedBox(width: AppConstants.spacing16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.name ?? 'User',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              user?.email ?? 'user@example.com',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.onSurfaceVariant),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppConstants.spacing16),

            // Menu sections
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacing16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Account section
                  _buildSectionHeader(context, 'Account'),
                  const SizedBox(height: AppConstants.spacing8),

                  Card(
                    child: Column(
                      children: [
                        _buildMenuItem(
                          context,
                          icon: Icons.person_outline,
                          title: 'Profile',
                          subtitle: 'Manage your personal information',
                          onTap: () => context.push(AppRoutes.editProfile),
                        ),
                        const Divider(indent: 72),
                        _buildMenuItem(
                          context,
                          icon: Icons.language_outlined,
                          title: 'Language',
                          subtitle: 'Change app language',
                          onTap: () => context.push(AppRoutes.language),
                        ),
                        const Divider(indent: 72),
                        _buildMenuItem(
                          context,
                          icon: Icons.history_outlined,
                          title: 'Activity',
                          subtitle: 'View your recent activities',
                          onTap: () => context.push(AppRoutes.activity),
                        ),
                        const Divider(indent: 72),
                        _buildMenuItem(
                          context,
                          icon: Icons.favorite_outline,
                          title: 'Favorites',
                          subtitle: 'Manage saved locations',
                          onTap: () => context.push(AppRoutes.favorites),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppConstants.spacing24),

                  // General section
                  _buildSectionHeader(context, 'General'),
                  const SizedBox(height: AppConstants.spacing8),

                  Card(
                    child: Column(
                      children: [
                        _buildMenuItem(
                          context,
                          icon: Icons.notifications_outlined,
                          title: 'Notice',
                          subtitle: 'App announcements and updates',
                          onTap: () => context.push(AppRoutes.notice),
                        ),
                        const Divider(indent: 72),
                        _buildMenuItem(
                          context,
                          icon: Icons.help_outline,
                          title: 'Help Center',
                          subtitle: 'Get help and support',
                          onTap: () => context.push(AppRoutes.helpCenter),
                        ),
                        const Divider(indent: 72),
                        _buildMenuItem(
                          context,
                          icon: Icons.eco_outlined,
                          title: 'Green Dashboard',
                          subtitle: 'Track your environmental impact',
                          onTap: () => context.push(AppRoutes.greenDashboard),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppConstants.spacing32),

                  // Logout
                  Card(
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            AppConstants.radiusMedium,
                          ),
                        ),
                        child: const Icon(
                          Icons.logout,
                          color: AppColors.error,
                          size: 20,
                        ),
                      ),
                      title: const Text(
                        'Logout',
                        style: TextStyle(
                          color: AppColors.error,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: const Text('Sign out of your account'),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: AppColors.error,
                      ),
                      onTap: () async {
                        // Show loading indicator
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        );

                        // Sign out and clear all data
                        await authService.signOut();

                        // Small delay to ensure data is cleared
                        await Future.delayed(const Duration(milliseconds: 100));

                        // Force navigation to login
                        if (context.mounted) {
                          // Close loading dialog
                          Navigator.pop(context);
                          // Navigate to login
                          context.go(AppRoutes.login);
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: AppConstants.spacing24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: AppColors.onSurfaceVariant,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.onSurfaceVariant,
      ),
      onTap: onTap,
    );
  }
}
