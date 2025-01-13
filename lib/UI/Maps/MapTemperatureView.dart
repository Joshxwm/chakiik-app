import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTemperatureView extends StatefulWidget {
  @override
  _MapTemperatureViewState createState() => _MapTemperatureViewState();
}

class _MapTemperatureViewState extends State<MapTemperatureView> {
  late GoogleMapController _mapController;

  // Lista de datos con ubicaciones y sus temperaturas
  final List<Map<String, dynamic>> _temperatureData = [
    {'position': LatLng(20.0, -87.0), 'temperature': 35},
    {'position': LatLng(19.5, -87.5), 'temperature': 28},
    {'position': LatLng(20.5, -86.5), 'temperature': 22},
  ];

  // Generar círculos para representar la temperatura
  Set<Circle> _createTemperatureCircles() {
    return _temperatureData.map((data) {
      double temperature = data['temperature'];
      LatLng position = data['position'];

      // Determinar el color según la temperatura
      Color color;
      if (temperature > 30) {
        color = Colors.red;
      } else if (temperature > 20) {
        color = Colors.orange;
      } else {
        color = Colors.blue;
      }

      return Circle(
        circleId: CircleId(position.toString()),
        center: position,
        radius: 50000, // Radio en metros
        fillColor: color.withOpacity(0.5),
        strokeColor: color,
        strokeWidth: 2,
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de Temperaturas'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(20.0, -87.0), // Centro inicial del mapa
          zoom: 7,
        ),
        onMapCreated: (controller) => _mapController = controller,
        circles: _createTemperatureCircles(),
      ),
    );
  }
}
