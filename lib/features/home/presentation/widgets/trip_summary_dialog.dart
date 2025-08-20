import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/models/ride.dart';

class TripSummaryDialog extends StatefulWidget {
  final Ride ride;
  final Function(double rating, String? review) onRatingSubmitted;
  final VoidCallback onClose;

  const TripSummaryDialog({
    super.key,
    required this.ride,
    required this.onRatingSubmitted,
    required this.onClose,
  });

  @override
  State<TripSummaryDialog> createState() => _TripSummaryDialogState();
}

class _TripSummaryDialogState extends State<TripSummaryDialog> {
  double _rating = 5.0;
  final TextEditingController _reviewController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _submitRating() async {
    setState(() {
      _isSubmitting = true;
    });

    await widget.onRatingSubmitted(
      _rating,
      _reviewController.text.isEmpty ? null : _reviewController.text,
    );

    setState(() {
      _isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spacing24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                size: 40,
                color: AppColors.success,
              ),
            ),
            const SizedBox(height: AppConstants.spacing16),

            Text(
              'Trip Completed!',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppConstants.spacing8),

            Text(
              'Thank you for riding with KOKKOK Move',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppConstants.spacing24),

            // Trip summary
            Container(
              padding: const EdgeInsets.all(AppConstants.spacing16),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
              ),
              child: Column(
                children: [
                  _buildSummaryRow(
                    'Fare',
                    '฿${widget.ride.fare?.toStringAsFixed(0) ?? '0'}',
                  ),
                  const SizedBox(height: AppConstants.spacing8),
                  _buildSummaryRow(
                    'Distance',
                    '${widget.ride.distance?.toStringAsFixed(1) ?? '0'} km',
                  ),
                  const SizedBox(height: AppConstants.spacing8),
                  _buildSummaryRow(
                    'Duration',
                    '${widget.ride.duration ?? 0} min',
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppConstants.spacing24),

            // Rating
            Text(
              'Rate your trip',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppConstants.spacing12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _rating = index + 1.0;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      Icons.star,
                      size: 32,
                      color: index < _rating
                          ? AppColors.warning
                          : AppColors.onSurfaceVariant,
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: AppConstants.spacing16),

            // Review text field
            TextField(
              controller: _reviewController,
              decoration: const InputDecoration(
                hintText: 'Leave a review (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              maxLength: 200,
            ),

            const SizedBox(height: AppConstants.spacing24),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onClose,
                    child: const Text('Skip'),
                  ),
                ),
                const SizedBox(width: AppConstants.spacing12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitRating,
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.onPrimary,
                            ),
                          )
                        : const Text('Submit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant),
        ),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }
}
