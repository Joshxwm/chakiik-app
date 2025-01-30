// Menu principal

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController.loadRequest(Uri.parse(
        "https://atlas.microsoft.com/map/tile?subscription-key={040cd95f-1794-497d-89de-882c737a98fc}&api-version=2021-02-01&tilesetId=microsoft.base.road&zoom=15&x=5236&y=12665&tileSize=256"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bienvenido Usuario!"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(context, Icons.people, "Red de Ayuda"),
                _buildActionButton(
                    context, Icons.info, "Información de Seguridad"),
                _buildActionButton(
                    context, Icons.volunteer_activism, "Contacta Rescatistas"),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Row(
                children: [
                  Expanded(child: _buildAzureMap()),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: const Text("VER MÁS MAPAS"),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Comunidad"),
          BottomNavigationBarItem(
              icon: Icon(Icons.offline_bolt), label: "Offline"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Configuración"),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Icon(icon, size: 30),
        ),
        const SizedBox(height: 5),
        Text(label, textAlign: TextAlign.center),
      ],
    );
  }

  Widget _buildAzureMap() {
    return SizedBox(
      height: 200,
      child: WebViewWidget(controller: _webViewController),
    );
  }
}
