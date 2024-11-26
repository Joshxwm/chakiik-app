// Para manejar la lógica de conexión con la API de Azure y recuperar datos de huracanes

import 'dart:convert';
import 'package:chakiik_app/models/Hurricane.dart';
import 'package:http/http.dart' as http;

class Hurricaneservice {
  final String baseUrl =
      "https://api.weatherapi.com/v1/current.json?key=00286ec3e8114a0eaf620509241811&q=19.5776,-88.1544";

  //Obtener List de Huracanes
  Future<List<Hurricane>> fetchHurricanes() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      return data.map((json) => Hurricane.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los huracanes');
    }
  }
}
