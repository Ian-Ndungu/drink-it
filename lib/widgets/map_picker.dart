import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart'; // Import location package
import '../utils/colors.dart';

class MapPicker extends StatefulWidget {
  const MapPicker({super.key});

  @override
  _MapPickerState createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  GoogleMapController? _controller;
  LatLng? _pickedLocation;
  LocationData? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final Location location = Location();

    try {
      final LocationData currentLocation = await location.getLocation();
      setState(() {
        _currentLocation = currentLocation;
        if (_currentLocation != null) {
          _controller?.animateCamera(
            CameraUpdate.newLatLng(
              LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
            ),
          );
        }
      });
    } catch (e) {
      print('Could not get current location: $e');
      // Optionally, handle location permission errors or other issues
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    if (_currentLocation != null) {
      _controller?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Location'),
        backgroundColor: AppColors.mainColor,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _currentLocation != null
                  ? LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!)
                  : const LatLng(-1.286389, 36.817223), // Fallback location if current location is not available
              zoom: 14.0,
            ),
            markers: _pickedLocation != null
                ? {
                    Marker(
                      markerId: const MarkerId('pickedLocation'),
                      position: _pickedLocation!,
                    ),
                  }
                : {},
            onTap: (location) {
              setState(() {
                _pickedLocation = location;
              });
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_pickedLocation != null) {
                    Navigator.of(context).pop(_pickedLocation);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please pick a location'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                child: const Text('Confirm Location', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
