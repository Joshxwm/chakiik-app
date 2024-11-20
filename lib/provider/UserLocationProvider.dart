// ignore: file_names

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final userLocationProvider =
    StateNotifierProvider<UserLocationNotifier, Position?>(
  (ref) => UserLocationNotifier(),
);

class UserLocationNotifier extends StateNotifier<Position?> {
  UserLocationNotifier() : super(null);

  Future<void> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si los servicios de ubicación están habilitados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Los servicios de ubicación están deshabilitados");
    }

    // Verificar los permisos de ubicación
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        throw Exception("Permiso de ubicación denegado");
      }
    }

    // Obtener la ubicación actual
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Actualizar el estado con la nueva ubicación
    state = position;
  }
}
