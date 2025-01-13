import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';

class MapPrecipitationView extends StatelessWidget {
  final String azureMapsApiKey;
  final String openWeatherApiKey;

  MapPrecipitationView({
    required this.azureMapsApiKey,
    required this.openWeatherApiKey,
  });

  @override
  Widget build(BuildContext context) {
    // Código HTML para el mapa con precipitación
    final String mapHtml = '''
      <!DOCTYPE html>
      <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
          html, body {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
          }
          #map {
            width: 100%;
            height: 100%;
          }
        </style>
        <script src="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas.min.js"></script>
        <link rel="stylesheet" href="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas.min.css" />
      </head>
      <body>
        <div id="map"></div>
        <script>
          const subscriptionKey = '$azureMapsApiKey';

          // Inicializar el mapa
          const map = new atlas.Map('map', {
            center: [-87.466, 20.214], // Felipe Carrillo Puerto, México
            zoom: 6,
            authOptions: {
              authType: 'subscriptionKey',
              subscriptionKey: subscriptionKey
            }
          });

          map.events.add('ready', function () {
            // Agregar capa de precipitación desde OpenWeatherMap
            map.layers.add(new atlas.layer.TileLayer({
              tileUrl: 'https://tile.openweathermap.org/map/precipitation_new/{z}/{x}/{y}.png?appid=$openWeatherApiKey',
              tileSize: 256
            }));
          });
        </script>
      </body>
      </html>
    ''';

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de Precipitación'),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted, //Aquí estaba el error
        initialUrl: Uri.dataFromString(
          mapHtml,
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
        ).toString(),
      ),
    );
  }

  WebView({required javascriptMode, required String initialUrl}) {}
}

class JavascriptMode {
  static var unrestricted;
}
