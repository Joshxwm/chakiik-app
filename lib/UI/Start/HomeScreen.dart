// Menu principal

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final WebViewController _webViewController;

  // Método para comunicarte con código nativo
  static const MethodChannel _channel = MethodChannel('chakiik/maps');

  Future<void> _openAzureMap() async {
    try {
      await _channel.invokeMethod('showAzureMap');
    } on PlatformException catch (e) {
      print("Error al abrir el mapa: ${e.message}");
    }
  }

  @override
  void initState() {
    super.initState();
    _webViewController.loadRequest(
      Uri.parse(
          "https://atlas.microsoft.com/map/tile?subscription-key=EAWswl7KoGcahSOXPwFHOmMYuUlOx5O4uI0lI4Yd8GwD5o0lMzNtJQQJ99BAACYeBjFSGE5tAAAgAZMP2QWv&api-version=2021-02-01"
          "&microsoft.imagery=microsoft.weather.radar.main&zoom=5&x=10&y=10&tileSize=256"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bienvenido Usuario!"),
      ),
      body: Column(
        children: [
          Expanded(child: _buildAzureMap()),
          ElevatedButton(
            onPressed: _openAzureMap, // Abre el mapa nativo
            child: const Text("Abrir Mapas Satelitales"),
          ),
        ],
      ),
    );
  }

  Widget _buildAzureMap() {
    return WebViewWidget(controller: _webViewController);
  }
}
