import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/models/ride.dart';

class RideStatusCard extends StatelessWidget {
  final Ride ride;

  const RideStatusCard({super.key, required this.ride});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildStatusIcon(ride.status),
                const SizedBox(width: AppConstants.spacing12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getStatusTitle(ride.status),
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      if (ride.estimatedArrival != null &&
                          ride.estimatedArrival! > 0)
                        Text(
                          'ETA: ${ride.estimatedArrival} minutes',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.onSurfaceVariant),
                        ),
                    ],
                  ),
                ),
                if (ride.status == RideStatus.searching)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppConstants.spacing16),

            // Trip details
            Container(
              padding: const EdgeInsets.all(AppConstants.spacing12),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
              ),
              child: Column(
                children: [
                  _buildLocationRow(
                    icon: Icons.my_location,
                    label: 'From',
                    address:
                        ride.pickupLocation.address ??
                        ride.pickupLocation.name ??
                        'Pickup location',
                    iconColor: AppColors.success,
                  ),
                  const SizedBox(height: AppConstants.spacing8),
                  _buildLocationRow(
                    icon: Icons.location_on,
                    label: 'To',
                    address:
                        ride.destination.address ??
                        ride.destination.name ??
                        'Destination',
                    iconColor: AppColors.error,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon(RideStatus status) {
    IconData icon;
    Color color;

    switch (status) {
      case RideStatus.searching:
        icon = Icons.search;
        color = AppColors.warning;
        break;
      case RideStatus.driverAssigned:
      case RideStatus.driverOnWay:
        icon = Icons.directions_car;
        color = AppColors.info;
        break;
      case RideStatus.driverArrived:
        icon = Icons.location_on;
        color = AppColors.primary;
        break;
      case RideStatus.inTransit:
      case RideStatus.nearDestination:
        icon = Icons.navigation;
        color = AppColors.success;
        break;
      case RideStatus.completed:
        icon = Icons.check_circle;
        color = AppColors.success;
        break;
      case RideStatus.cancelled:
        icon = Icons.cancel;
        color = AppColors.error;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  String _getStatusTitle(RideStatus status) {
    switch (status) {
      case RideStatus.searching:
        return 'Searching for driver...';
      case RideStatus.driverAssigned:
        return 'Driver assigned';
      case RideStatus.driverOnWay:
        return 'Driver is on the way';
      case RideStatus.driverArrived:
        return 'Driver has arrived';
      case RideStatus.inTransit:
        return 'In transit';
      case RideStatus.nearDestination:
        return 'Near destination';
      case RideStatus.completed:
        return 'Trip completed';
      case RideStatus.cancelled:
        return 'Trip cancelled';
    }
  }

  Widget _buildLocationRow({
    required IconData icon,
    required String label,
    required String address,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 16),
        const SizedBox(width: AppConstants.spacing8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: AppConstants.spacing8),
        Expanded(
          child: Text(
            address,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
