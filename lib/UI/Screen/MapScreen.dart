// Pantalla donde se verá el mapa con el seguimiento de huracanes

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  // ignore: unused_field
  Position? _currentPosition;
  final Set<Marker> _markers = {};

  void _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
        _markers.add(
          Marker(
            markerId: const MarkerId('user_location'),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: const InfoWindow(title: 'Tu ubicación'),
          ),
        );
      });
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)),
      );
    } catch (e) {
      // ignore: avoid_print
      print('Error al obtener la ubicación: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapa Interactivo"),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(19.432608,
              -99.133209), // Coordenadas iniciales (p.ej., Ciudad de México)
          zoom: 10,
        ),
        markers: _markers,
        onMapCreated: (controller) {
          _mapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getUserLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
