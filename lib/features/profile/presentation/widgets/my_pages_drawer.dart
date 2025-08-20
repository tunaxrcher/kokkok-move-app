import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/services/auth_service.dart';
import '../../../../core/di/injection_container.dart';

class MyPagesDrawer extends StatelessWidget {
  const MyPagesDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = sl<AuthService>();
    final user = authService.getCurrentUser();

    return Drawer(
      backgroundColor: AppColors.surface,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(AppConstants.spacing24),
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
                        radius: 25,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        backgroundImage: user?.photoUrl != null
                            ? NetworkImage(user!.photoUrl!)
                            : null,
                        child: user?.photoUrl == null
                            ? const Icon(
                                Icons.person,
                                size: 25,
                                color: AppColors.primary,
                              )
                            : null,
                      ),
                      const SizedBox(width: AppConstants.spacing12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.name ?? 'User',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              user?.email ?? 'user@example.com',
                              style: Theme.of(context).textTheme.bodySmall
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

            const Divider(),

            // Menu items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  vertical: AppConstants.spacing8,
                ),
                children: [
                  // Account section
                  _buildSectionHeader(context, 'Account'),
                  _buildMenuItem(
                    context,
                    icon: Icons.person_outline,
                    title: 'Profile',
                    onTap: () {
                      Navigator.pop(context);
                      context.push(AppRoutes.profile);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.language_outlined,
                    title: 'Language',
                    onTap: () {
                      Navigator.pop(context);
                      context.push(AppRoutes.language);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.history_outlined,
                    title: 'Activity',
                    onTap: () {
                      Navigator.pop(context);
                      context.push(AppRoutes.activity);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.favorite_outline,
                    title: 'Favorites',
                    onTap: () {
                      Navigator.pop(context);
                      context.push(AppRoutes.favorites);
                    },
                  ),

                  const SizedBox(height: AppConstants.spacing16),

                  // General section
                  _buildSectionHeader(context, 'General'),
                  _buildMenuItem(
                    context,
                    icon: Icons.notifications_outlined,
                    title: 'Notice',
                    onTap: () {
                      Navigator.pop(context);
                      context.push(AppRoutes.notice);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.help_outline,
                    title: 'Help Center',
                    onTap: () {
                      Navigator.pop(context);
                      context.push(AppRoutes.helpCenter);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.eco_outlined,
                    title: 'Green Dashboard',
                    onTap: () {
                      Navigator.pop(context);
                      context.push(AppRoutes.greenDashboard);
                    },
                  ),
                ],
              ),
            ),

            const Divider(),

            // Logout
            Padding(
              padding: const EdgeInsets.all(AppConstants.spacing16),
              child: ListTile(
                leading: const Icon(Icons.logout, color: AppColors.error),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    color: AppColors.error,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () async {
                  // Close the drawer first
                  Navigator.pop(context);

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

                  // Force navigation to login and clear navigation stack
                  if (context.mounted) {
                    // Close loading dialog
                    Navigator.pop(context);
                    // Navigate to login, this should trigger router redirect
                    context.go('/login');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.spacing24,
        AppConstants.spacing16,
        AppConstants.spacing24,
        AppConstants.spacing8,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: AppColors.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.onSurface),
      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.onSurfaceVariant,
      ),
      onTap: onTap,
    );
  }
}
