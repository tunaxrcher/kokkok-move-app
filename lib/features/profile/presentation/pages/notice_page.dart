import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_colors.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notice')),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppConstants.spacing16),
        itemCount: 4,
        itemBuilder: (context, index) {
          final notices = [
            'App Update v2.1.0 Available',
            'New Safety Features Added',
            'Holiday Schedule Changes',
            'Terms of Service Update',
          ];

          return Card(
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    AppConstants.radiusMedium,
                  ),
                ),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.info,
                  size: 20,
                ),
              ),
              title: Text(notices[index]),
              subtitle: const Text('Tap to read more'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(notices[index]),
                    content: const Text(
                      'This is a mock notice detail. In a real app, this would show the full notice content.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
