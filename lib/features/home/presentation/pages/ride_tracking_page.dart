import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/models/ride.dart';

import '../../../../shared/services/ride_service.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
import '../widgets/ride_status_card.dart';
import '../widgets/driver_info_card.dart';
import '../widgets/trip_summary_dialog.dart';

class RideTrackingPage extends ConsumerStatefulWidget {
  final String rideId;

  const RideTrackingPage({super.key, required this.rideId});

  @override
  ConsumerState<RideTrackingPage> createState() => _RideTrackingPageState();
}

class _RideTrackingPageState extends ConsumerState<RideTrackingPage> {
  GoogleMapController? _mapController;
  final RideService _rideService = sl<RideService>();
  Ride? _currentRide;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _startRideTracking();
  }

  void _startRideTracking() {
    _rideService.trackRide(widget.rideId).listen((ride) {
      setState(() {
        _currentRide = ride;
      });
      _updateMarkers(ride);

      if (ride.status == RideStatus.completed) {
        _showTripSummary(ride);
      }
    });
  }

  void _updateMarkers(Ride ride) {
    _markers.clear();

    // Pickup marker
    _markers.add(
      Marker(
        markerId: const MarkerId('pickup'),
        position: LatLng(
          ride.pickupLocation.latitude,
          ride.pickupLocation.longitude,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(title: 'Pickup'),
      ),
    );

    // Destination marker
    _markers.add(
      Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(ride.destination.latitude, ride.destination.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(title: 'Destination'),
      ),
    );

    // Driver marker (if available)
    if (ride.driver?.currentLocation != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('driver'),
          position: LatLng(
            ride.driver!.currentLocation!.latitude,
            ride.driver!.currentLocation!.longitude,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: ride.driver!.name),
        ),
      );
    }

    setState(() {});
  }

  void _showTripSummary(Ride ride) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => TripSummaryDialog(
        ride: ride,
        onRatingSubmitted: (rating, review) async {
          await _rideService.rateRide(ride.id, rating, review);
          if (mounted) {
            context.go(AppRoutes.home);
          }
        },
        onClose: () {
          context.go(AppRoutes.home);
        },
      ),
    );
  }

  String _getRideStatusText(RideStatus status) {
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

  @override
  Widget build(BuildContext context) {
    if (_currentRide == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_getRideStatusText(_currentRide!.status)),
        leading: IconButton(
          onPressed: () => context.go(AppRoutes.home),
          icon: const Icon(Icons.close),
        ),
      ),
      body: Stack(
        children: [
          // Map
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(
                _currentRide!.pickupLocation.latitude,
                _currentRide!.pickupLocation.longitude,
              ),
              zoom: AppConstants.defaultZoom,
            ),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
          ),

          // Bottom sheet with ride info
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.3,
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
                          // Ride status
                          RideStatusCard(ride: _currentRide!),

                          // Driver info (if available)
                          if (_currentRide!.driver != null) ...[
                            const SizedBox(height: AppConstants.spacing16),
                            DriverInfoCard(driver: _currentRide!.driver!),
                          ],

                          // Cancel button (only if ride hasn't started)
                          if (_currentRide!.status == RideStatus.searching ||
                              _currentRide!.status ==
                                  RideStatus.driverAssigned ||
                              _currentRide!.status ==
                                  RideStatus.driverOnWay) ...[
                            const SizedBox(height: AppConstants.spacing24),
                            OutlinedButton(
                              onPressed: () {
                                // TODO: Implement cancel ride
                                context.go(AppRoutes.home);
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppColors.error),
                                foregroundColor: AppColors.error,
                              ),
                              child: const Text('Cancel Ride'),
                            ),
                          ],
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
}
