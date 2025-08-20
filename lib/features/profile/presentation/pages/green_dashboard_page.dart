import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_colors.dart';

class GreenDashboardPage extends StatelessWidget {
  const GreenDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Green Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Total Trips',
                    value: '25',
                    icon: Icons.directions_car,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppConstants.spacing12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Green Miles',
                    value: '120.5',
                    icon: Icons.eco,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppConstants.spacing16),

            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'CO₂ Saved',
                    value: '15.2 kg',
                    icon: Icons.cloud_outlined,
                    color: AppColors.info,
                  ),
                ),
                const SizedBox(width: AppConstants.spacing12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Fuel Saved',
                    value: '8.5 L',
                    icon: Icons.local_gas_station,
                    color: AppColors.warning,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppConstants.spacing24),

            // Environmental impact
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.spacing16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Environmental Impact',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacing16),

                    // Tree equivalent
                    Container(
                      padding: const EdgeInsets.all(AppConstants.spacing16),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                          AppConstants.radiusLarge,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.park,
                            color: AppColors.success,
                            size: 32,
                          ),
                          const SizedBox(width: AppConstants.spacing16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tree Equivalent',
                                  style: Theme.of(context).textTheme.labelMedium
                                      ?.copyWith(
                                        color: AppColors.onSurfaceVariant,
                                      ),
                                ),
                                Text(
                                  '2.3 trees planted',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: AppColors.success,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  'equivalent CO₂ absorption',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: AppColors.onSurfaceVariant,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppConstants.spacing16),

                    // Progress indicators
                    _buildProgressItem(
                      context,
                      label: 'Monthly Goal Progress',
                      value: 0.65,
                      current: '65%',
                      target: 'Target: 50 trips',
                    ),

                    const SizedBox(height: AppConstants.spacing12),

                    _buildProgressItem(
                      context,
                      label: 'Carbon Reduction',
                      value: 0.8,
                      current: '80%',
                      target: 'vs. private car usage',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppConstants.spacing16),

            // Tips card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.spacing16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.lightbulb_outline,
                          color: AppColors.warning,
                        ),
                        const SizedBox(width: AppConstants.spacing8),
                        Text(
                          'Green Tips',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.spacing12),
                    const Text(
                      '• Share rides with others to reduce emissions\n'
                      '• Choose eco-friendly vehicles when available\n'
                      '• Combine multiple trips into one journey\n'
                      '• Walk or bike for short distances',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacing16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: AppConstants.spacing8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressItem(
    BuildContext context, {
    required String label,
    required double value,
    required String current,
    required String target,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              current,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacing4),
        LinearProgressIndicator(
          value: value,
          backgroundColor: AppColors.surfaceVariant,
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
        const SizedBox(height: AppConstants.spacing4),
        Text(
          target,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant),
        ),
      ],
    );
  }
}
