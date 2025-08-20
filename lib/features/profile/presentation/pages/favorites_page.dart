import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_colors.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add favorite location')),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppConstants.spacing16),
        itemCount: 3,
        itemBuilder: (context, index) {
          final locations = ['Home', 'Work', 'Gym'];
          final icons = [Icons.home, Icons.work, Icons.fitness_center];

          return Card(
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    AppConstants.radiusMedium,
                  ),
                ),
                child: Icon(icons[index], color: AppColors.primary, size: 20),
              ),
              title: Text(locations[index]),
              subtitle: const Text('123 Mock Street, Bangkok'),
              trailing: IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Removed ${locations[index]}')),
                  );
                },
                icon: const Icon(Icons.delete_outline, color: AppColors.error),
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected ${locations[index]}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
