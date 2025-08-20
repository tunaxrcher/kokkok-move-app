import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/models/location.dart' as app_models;
import '../../../../shared/services/location_service.dart';
import '../../../../core/di/injection_container.dart';

class LocationSearchSheet extends StatefulWidget {
  final bool isDestination;
  final Function(app_models.Location) onLocationSelected;

  const LocationSearchSheet({
    super.key,
    required this.isDestination,
    required this.onLocationSelected,
  });

  @override
  State<LocationSearchSheet> createState() => _LocationSearchSheetState();
}

class _LocationSearchSheetState extends State<LocationSearchSheet> {
  final TextEditingController _searchController = TextEditingController();
  final LocationService _locationService = sl<LocationService>();
  List<app_models.Location> _searchResults = [];
  bool _isSearching = false;

  final List<app_models.Location> _popularLocations = [
    const app_models.Location(
      latitude: 13.7563,
      longitude: 100.5018,
      address: 'Siam Square, Bangkok, Thailand',
      name: 'Siam Square',
    ),
    const app_models.Location(
      latitude: 13.7650,
      longitude: 100.5380,
      address: 'Terminal 21, Sukhumvit Road, Bangkok, Thailand',
      name: 'Terminal 21',
    ),
    const app_models.Location(
      latitude: 13.7460,
      longitude: 100.5340,
      address: 'Silom Road, Bangkok, Thailand',
      name: 'Silom',
    ),
    const app_models.Location(
      latitude: 13.7200,
      longitude: 100.5170,
      address: 'Chatuchak Weekend Market, Bangkok, Thailand',
      name: 'Chatuchak Market',
    ),
    const app_models.Location(
      latitude: 13.7367,
      longitude: 100.5606,
      address: 'EmQuartier, Sukhumvit Road, Bangkok, Thailand',
      name: 'EmQuartier',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchResults = _popularLocations;
  }

  Future<void> _searchLocations(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = _popularLocations;
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final results = await _locationService.searchLocations(query);
      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _searchResults = _popularLocations
            .where(
              (location) =>
                  location.name!.toLowerCase().contains(query.toLowerCase()) ||
                  (location.address?.toLowerCase().contains(
                        query.toLowerCase(),
                      ) ??
                      false),
            )
            .toList();
        _isSearching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusXLarge),
        ),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(
              vertical: AppConstants.spacing12,
            ),
            decoration: BoxDecoration(
              color: AppColors.onSurfaceVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacing16,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                Expanded(
                  child: Text(
                    widget.isDestination
                        ? 'Select destination'
                        : 'Select pickup location',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Search bar
          Padding(
            padding: const EdgeInsets.all(AppConstants.spacing16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for a location',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          _searchLocations('');
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
              ),
              onChanged: _searchLocations,
            ),
          ),

          // Results
          Expanded(
            child: _isSearching
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.spacing16,
                    ),
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final location = _searchResults[index];
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
                            child: Icon(
                              widget.isDestination
                                  ? Icons.location_on
                                  : Icons.my_location,
                              color: AppColors.primary,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            location.name ?? 'Unknown Location',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            location.address ??
                                '${location.latitude}, ${location.longitude}',
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            widget.onLocationSelected(location);
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
