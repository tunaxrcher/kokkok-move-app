import 'package:flutter/material.dart';
import 'dart:async';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/models/location.dart' as app_models;
import '../../../../shared/services/location_service.dart';
import '../../../../shared/services/google_places_service.dart';
import '../../../../core/di/injection_container.dart';

class LocationSearchSheet extends StatefulWidget {
  final bool isDestination;
  final Function(app_models.Location) onLocationSelected;
  final app_models.Location? currentLocation;

  const LocationSearchSheet({
    super.key,
    required this.isDestination,
    required this.onLocationSelected,
    this.currentLocation,
  });

  @override
  State<LocationSearchSheet> createState() => _LocationSearchSheetState();
}

class _LocationSearchSheetState extends State<LocationSearchSheet> {
  final TextEditingController _searchController = TextEditingController();
  final LocationService _locationService = sl<LocationService>();
  List<PlacePrediction> _predictions = [];
  List<app_models.Location> _nearbyPlaces = [];
  bool _isSearching = false;
  bool _isLoadingNearby = false;
  Timer? _debounceTimer;
  final String _sessionToken = const Uuid().v4();

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
    _loadNearbyPlaces();
  }

  Future<void> _loadNearbyPlaces() async {
    if (widget.currentLocation == null || !widget.isDestination) return;

    setState(() {
      _isLoadingNearby = true;
    });

    try {
      final nearbyPlaces = await _locationService.getNearbyPlaces(
        widget.currentLocation!,
        radius: 10000, // 10km radius
        type: 'establishment',
      );

      setState(() {
        _nearbyPlaces = nearbyPlaces;
        _isLoadingNearby = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingNearby = false;
      });
    }
  }

  void _onSearchChanged(String query) {
    // Cancel previous timer
    _debounceTimer?.cancel();

    // Start new timer
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _searchPlaces(query);
    });
  }

  Future<void> _searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() {
        _predictions = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final predictions = await _locationService.getPlacePredictions(
        query,
        currentLocation: widget.currentLocation,
        sessionToken: _sessionToken,
      );

      setState(() {
        _predictions = predictions;
        _isSearching = false;
      });
    } catch (e) {
      print('Search places error: $e');
      setState(() {
        _predictions = [];
        _isSearching = false;
      });
    }
  }

  Future<void> _selectPlace(PlacePrediction prediction) async {
    setState(() {
      _isSearching = true;
    });

    try {
      final location = await _locationService.getPlaceDetails(
        prediction.placeId,
      );
      if (location != null) {
        widget.onLocationSelected(location);
        if (mounted) {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      print('Select place error: $e');
    } finally {
      setState(() {
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
                          _onSearchChanged('');
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
              ),
              onChanged: _onSearchChanged,
            ),
          ),

          // Results
          Expanded(
            child: _isSearching
                ? const Center(child: CircularProgressIndicator())
                : _searchController.text.isNotEmpty
                ? _buildPredictionsList()
                : _buildDefaultContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildPredictionsList() {
    if (_predictions.isEmpty) {
      return const Center(child: Text('ไม่พบสถานที่ที่ค้นหา'));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing16),
      itemCount: _predictions.length,
      itemBuilder: (context, index) {
        final prediction = _predictions[index];
        return Card(
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
              ),
              child: Icon(Icons.place, color: AppColors.primary, size: 20),
            ),
            title: Text(
              prediction.mainText ?? prediction.description,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            subtitle: prediction.secondaryText != null
                ? Text(
                    prediction.secondaryText!,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                : null,
            onTap: () => _selectPlace(prediction),
          ),
        );
      },
    );
  }

  Widget _buildDefaultContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current location option (for pickup only)
          if (!widget.isDestination && widget.currentLocation != null) ...[
            Text(
              'ตำแหน่งปัจจุบัน',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppConstants.spacing8),
            Card(
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(
                      AppConstants.radiusMedium,
                    ),
                  ),
                  child: const Icon(
                    Icons.my_location,
                    color: AppColors.success,
                    size: 20,
                  ),
                ),
                title: const Text('ตำแหน่งปัจจุบันของฉัน'),
                subtitle: Text(
                  widget.currentLocation!.address ?? 'ตำแหน่งปัจจุบัน',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  widget.onLocationSelected(widget.currentLocation!);
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: AppConstants.spacing16),
          ],

          // Nearby places (for destination only)
          if (widget.isDestination && _nearbyPlaces.isNotEmpty) ...[
            Text(
              'สถานที่ใกล้เคียง',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppConstants.spacing8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _nearbyPlaces.length > 10 ? 10 : _nearbyPlaces.length,
              itemBuilder: (context, index) {
                final place = _nearbyPlaces[index];
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
                      child: const Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      place.name ?? 'Unknown Place',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      place.address ?? '',
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      widget.onLocationSelected(place);
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: AppConstants.spacing16),
          ],

          // Loading nearby places
          if (widget.isDestination && _isLoadingNearby) ...[
            const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: AppConstants.spacing8),
                  Text('กำลังค้นหาสถานที่ใกล้เคียง...'),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.spacing16),
          ],

          // Popular locations
          Text(
            'สถานที่ยอดนิยม',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppConstants.spacing8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _popularLocations.length,
            itemBuilder: (context, index) {
              final location = _popularLocations[index];
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
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
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
        ],
      ),
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }
}
