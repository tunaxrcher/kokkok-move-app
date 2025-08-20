import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_colors.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contact methods
            Text(
              'Get in Touch',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppConstants.spacing16),

            _buildContactCard(
              context,
              icon: Icons.phone,
              title: 'Call Us',
              subtitle: '+66 2 123 4567',
              color: AppColors.success,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening phone app...')),
                );
              },
            ),

            const SizedBox(height: AppConstants.spacing12),

            _buildContactCard(
              context,
              icon: Icons.email,
              title: 'Email Us',
              subtitle: 'support@kokkokmove.com',
              color: AppColors.info,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening email app...')),
                );
              },
            ),

            const SizedBox(height: AppConstants.spacing12),

            _buildContactCard(
              context,
              icon: Icons.chat,
              title: 'Live Chat',
              subtitle: 'Available 24/7',
              color: AppColors.primary,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening chat...')),
                );
              },
            ),

            const SizedBox(height: AppConstants.spacing32),

            // FAQ section
            Text(
              'Quick Help',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppConstants.spacing16),

            ...[
              {
                'title': 'How to book a ride?',
                'answer':
                    'Tap the home tab, select pickup and destination, then tap "Book Ride".',
              },
              {
                'title': 'How to cancel a booking?',
                'answer':
                    'You can cancel your ride from the tracking screen before the driver arrives.',
              },
              {
                'title': 'Payment issues?',
                'answer':
                    'Contact our support team for payment-related queries.',
              },
              {
                'title': 'Driver not arriving?',
                'answer':
                    'You can call the driver directly or contact support for assistance.',
              },
            ].map(
              (faq) => Card(
                child: ExpansionTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(
                        AppConstants.radiusMedium,
                      ),
                    ),
                    child: const Icon(
                      Icons.help_outline,
                      color: AppColors.warning,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    faq['title']!,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppConstants.spacing16),
                      child: Text(
                        faq['answer']!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppConstants.spacing32),

            // Emergency contact
            Card(
              color: AppColors.error.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.spacing16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.emergency, color: AppColors.error),
                        const SizedBox(width: AppConstants.spacing8),
                        Text(
                          'Emergency Contact',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.error,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.spacing8),
                    const Text(
                      'For immediate assistance during rides, call our 24/7 emergency hotline:',
                    ),
                    const SizedBox(height: AppConstants.spacing8),
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Calling emergency hotline...'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: AppColors.white,
                      ),
                      icon: const Icon(Icons.phone),
                      label: const Text('Call 1669'),
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

  Widget _buildContactCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
