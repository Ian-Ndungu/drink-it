import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../utils/colors.dart';

class MapPicker extends StatefulWidget {
  const MapPicker({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapPickerState createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  // ignore: unused_field
  GoogleMapController? _controller;
  final LatLng _center = const LatLng(-1.286389, 36.817223); // Default location (Nairobi)
  LatLng? _pickedLocation;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
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
              target: _center,
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