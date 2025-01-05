import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrajectoryMapScreen extends StatelessWidget {
  const TrajectoryMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapas de trayectoria'),
      ),
      body: const TrajectoryMap(),
    );
  }
}

class WindMapScreen extends StatelessWidget {
  const WindMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapas de viento'),
      ),
      body: const WindMap(),
    );
  }
}

class TrajectoryMap extends StatefulWidget {
  const TrajectoryMap({super.key});

  @override
  State<TrajectoryMap> createState() => _TrajectoryMapState();
}

class _TrajectoryMapState extends State<TrajectoryMap> {
  late GoogleMapController _mapController;
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _initializeTrajectory();
  }

  void _initializeTrajectory() {
    // Ejemplo de trayectoria
    _polylines.add(Polyline(
      polylineId: const PolylineId('trajectory1'),
      points: [
        const LatLng(18.5, -88.3), // Cancún
        const LatLng(19.5, -89.2), // Mérida
        const LatLng(20.7, -90.4), // Campeche
      ],
      color: Colors.red,
      width: 5,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(19.0, -89.0), // Punto inicial
        zoom: 6.5,
      ),
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
      },
      polylines: _polylines,
    );
  }
}

class WindMap extends StatefulWidget {
  const WindMap({super.key});

  @override
  State<WindMap> createState() => _WindMapState();
}

class _WindMapState extends State<WindMap> {
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(19.0, -89.0), // Punto inicial
        zoom: 6.5,
      ),
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
      },
      // Ejemplo de marcador que podría representar un punto de viento fuerte
      markers: {
        Marker(
          markerId: const MarkerId('wind1'),
          position: const LatLng(20.0, -88.5),
          infoWindow: const InfoWindow(
            title: 'Viento fuerte',
            snippet: '50 km/h',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      },
    );
  }
}
