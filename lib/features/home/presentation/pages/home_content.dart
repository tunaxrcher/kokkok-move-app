import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/models/location.dart' as app_models;
import '../../../../shared/models/ride.dart';
import '../../../../shared/services/location_service.dart';
import '../../../../shared/services/ride_service.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
import '../widgets/location_search_sheet.dart';
import '../widgets/fare_estimate_card.dart';

class HomeContent extends ConsumerStatefulWidget {
  const HomeContent({super.key});

  @override
  ConsumerState<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends ConsumerState<HomeContent> {
  GoogleMapController? _mapController;
  app_models.Location? _currentLocation;
  app_models.Location? _pickupLocation;
  app_models.Location? _destinationLocation;
  FareEstimate? _fareEstimate;
  bool _isLoadingLocation = true;
  bool _isLoadingFare = false;

  final Set<Marker> _markers = {};
  final LocationService _locationService = sl<LocationService>();
  final RideService _rideService = sl<RideService>();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      print('🔍 Getting current location...');
      final location = await _locationService.getCurrentLocation();
      if (location != null && mounted) {
        print('✅ Got location: ${location.latitude}, ${location.longitude}');
        setState(() {
          _currentLocation = location;
          _pickupLocation = location;
          _isLoadingLocation = false;
        });
        _updateMarkers();
      } else {
        print('❌ Location service returned null');
        _setDefaultLocation();
      }
    } catch (e) {
      print('❌ Error getting location: $e');
      _setDefaultLocation();
    }
  }

  void _setDefaultLocation() {
    if (mounted) {
      print('🏠 Setting default location (Bangkok)');
      setState(() {
        _currentLocation = const app_models.Location(
          latitude: 13.7563,
          longitude: 100.5018,
          address: 'Bangkok, Thailand',
          name: 'Bangkok',
        );
        _pickupLocation = _currentLocation;
        _isLoadingLocation = false;
      });
      _updateMarkers();
    }
  }

  void _moveToLocation(app_models.Location location) {
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(location.latitude, location.longitude),
        AppConstants.defaultZoom,
      ),
    );
  }

  void _updateMarkers() {
    _markers.clear();

    if (_pickupLocation != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('pickup'),
          position: LatLng(
            _pickupLocation!.latitude,
            _pickupLocation!.longitude,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
          infoWindow: InfoWindow(
            title: 'Pickup',
            snippet: _pickupLocation!.address ?? _pickupLocation!.name,
          ),
        ),
      );
    }

    if (_destinationLocation != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('destination'),
          position: LatLng(
            _destinationLocation!.latitude,
            _destinationLocation!.longitude,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: 'Destination',
            snippet:
                _destinationLocation!.address ?? _destinationLocation!.name,
          ),
        ),
      );
    }

    setState(() {});
  }

  Future<void> _calculateFare() async {
    if (_pickupLocation == null || _destinationLocation == null) return;

    setState(() {
      _isLoadingFare = true;
    });

    try {
      final estimate = await _rideService.getFareEstimate(
        _pickupLocation!,
        _destinationLocation!,
      );
      setState(() {
        _fareEstimate = estimate;
        _isLoadingFare = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingFare = false;
      });
    }
  }

  Future<void> _bookRide() async {
    if (_pickupLocation == null || _destinationLocation == null) return;

    try {
      final ride = await _rideService.bookRide(
        _pickupLocation!,
        _destinationLocation!,
      );
      if (mounted) {
        context.push(AppRoutes.rideTracking(ride.id));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ไม่สามารถเรียกรถได้ กรุณาลองใหม่อีกครั้ง'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _showLocationSearch({required bool isDestination}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => LocationSearchSheet(
        isDestination: isDestination,
        currentLocation: _currentLocation,
        onLocationSelected: (location) {
          setState(() {
            if (isDestination) {
              _destinationLocation = location;
            } else {
              _pickupLocation = location;
            }
          });
          _updateMarkers();
          _moveToLocation(location);

          if (_pickupLocation != null && _destinationLocation != null) {
            _calculateFare();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map Area
          _isLoadingLocation
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    // Google Maps (requires API key)
                    GoogleMap(
                      onMapCreated: (GoogleMapController controller) {
                        _mapController = controller;
                        print('Google Map created successfully!');
                      },
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          _currentLocation?.latitude ?? 13.7563,
                          _currentLocation?.longitude ?? 100.5018,
                        ),
                        zoom: AppConstants.defaultZoom,
                      ),
                      markers: _markers,
                      myLocationEnabled:
                          false, // Disable for now to avoid permission issues
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: true, // Enable for testing
                      mapToolbarEnabled: false,
                      mapType: MapType.normal,
                      onTap: (LatLng position) {
                        print(
                          'Map tapped at: ${position.latitude}, ${position.longitude}',
                        );
                      },
                    ),

                    // Profile icon on top of map
                    Positioned(
                      top: 50,
                      left: 16,
                      child: SafeArea(
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to My Pages
                            context.push(AppRoutes.myPages);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(
                                AppConstants.radiusLarge,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.person,
                              color: AppColors.primary,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

          // Bottom sheet with location inputs and book ride button
          DraggableScrollableSheet(
            initialChildSize: 0.35,
            minChildSize: 0.35,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
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

                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: const EdgeInsets.all(AppConstants.spacing16),
                        children: [
                          Text(
                            'คุณต้องการไปที่ไหน?',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: AppConstants.spacing16),

                          // Pickup location
                          _buildLocationCard(
                            icon: Icons.my_location,
                            title: 'จุดรับ',
                            subtitle:
                                _pickupLocation?.address ??
                                _pickupLocation?.name ??
                                'เลือกจุดรับ',
                            onTap: () =>
                                _showLocationSearch(isDestination: false),
                            iconColor: AppColors.success,
                          ),

                          const SizedBox(height: AppConstants.spacing12),

                          // Destination location
                          _buildLocationCard(
                            icon: Icons.location_on,
                            title: 'จุดหมาย',
                            subtitle:
                                _destinationLocation?.address ??
                                _destinationLocation?.name ??
                                'ไปที่ไหน?',
                            onTap: () =>
                                _showLocationSearch(isDestination: true),
                            iconColor: AppColors.error,
                          ),

                          if (_fareEstimate != null) ...[
                            const SizedBox(height: AppConstants.spacing16),
                            FareEstimateCard(fareEstimate: _fareEstimate!),
                          ],

                          const SizedBox(height: AppConstants.spacing24),

                          // Book ride button
                          ElevatedButton(
                            onPressed:
                                _pickupLocation != null &&
                                    _destinationLocation != null
                                ? _bookRide
                                : null,
                            child: _isLoadingFare
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.onPrimary,
                                    ),
                                  )
                                : const Text(
                                    'เรียกรถ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color iconColor,
  }) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        title: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: AppColors.onSurfaceVariant),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
