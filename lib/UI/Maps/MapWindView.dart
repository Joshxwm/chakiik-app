import 'dart:convert';

import 'package:chakiik_app/UI/Maps/MapPrecipitationView.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapWindView extends StatefulWidget {
  @override
  _MapWindViewState createState() => _MapWindViewState();
}

class _MapWindViewState extends State<MapWindView> {
  late WebViewController _controller;

  // Inserta tu clave de API de Azure Maps aquí
  final String azureMapsApiKey = "TU_CLAVE_API";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de Viento'),
      ),
      body: WebView(
        initialUrl: _buildMapUrl(),
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
      ),
    );
  }

  // Construye la URL del mapa con las configuraciones necesarias
  String _buildMapUrl() {
    return Uri.dataFromString('''
      <!DOCTYPE html>
      <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas.min.js"></script>
        <link rel="stylesheet" href="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas.min.css" type="text/css">
        <style>
          html, body, #map {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
          }
        </style>
      </head>
      <body>
        <div id="map"></div>
        <script>
          let map;
          function initializeMap() {
            map = new atlas.Map('map', {
              center: [-100.5, 20.0], // Centro inicial del mapa (ajústalo según la región deseada)
              zoom: 4,
              view: 'Auto',
              authOptions: {
                authType: 'subscriptionKey',
                subscriptionKey: '$azureMapsApiKey'
              }
            });

            map.events.add('ready', () => {
              // Añadir la capa de viento
              map.layers.add(new atlas.layer.TileLayer({
                tileUrl: 'https://atlas.microsoft.com/map/tile?api-version=2.0&tilesetId=weather.wind-stream&x={x}&y={y}&z={z}&subscription-key=$azureMapsApiKey',
                opacity: 0.7
              }));
            });
          }

          window.onload = initializeMap;
        </script>
      </body>
      </html>
    ''', mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString();
  }

  WebView(
      {required String initialUrl,
      required javascriptMode,
      required Null Function(WebViewController webViewController)
          onWebViewCreated}) {}
}
