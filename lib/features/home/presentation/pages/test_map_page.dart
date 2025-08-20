import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TestMapPage extends StatefulWidget {
  const TestMapPage({super.key});

  @override
  State<TestMapPage> createState() => _TestMapPageState();
}

class _TestMapPageState extends State<TestMapPage> {
  GoogleMapController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Google Maps'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[900],
            child: const Text(
              'Testing Google Maps Integration',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
                print('✅ Google Map created successfully!');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Google Map loaded successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(13.7563, 100.5018), // Bangkok
                zoom: 12.0,
              ),
              onTap: (LatLng position) {
                print(
                  '🗺️ Map tapped at: ${position.latitude}, ${position.longitude}',
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Tapped: ${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}',
                    ),
                  ),
                );
              },
              markers: {
                const Marker(
                  markerId: MarkerId('bangkok'),
                  position: LatLng(13.7563, 100.5018),
                  infoWindow: InfoWindow(
                    title: 'Bangkok',
                    snippet: 'Capital of Thailand',
                  ),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
