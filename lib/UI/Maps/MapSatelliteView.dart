//import 'package:flutter/material.dart';
//import 'package:webview_flutter/webview_flutter.dart';

//class MapSatelliteView extends StatefulWidget {
 // @override
//  _MapSatelliteViewState createState() => _MapSatelliteViewState();
//}

//class _MapSatelliteViewState extends State<MapSatelliteView> {
 // late WebViewController _controller;

  // Inserta tu clave de API de Azure Maps aquí
 // final String azureMapsApiKey = "TU_CLAVE_API";

 // @override
 // Widget build(BuildContext context) {
   // return Scaffold(
   //   appBar: AppBar(
   //     title: Text('Mapa Satelital'),
    //  ),
    //  body: WebView(
    //    initialUrl: _buildMapUrl(),
    //    javascriptMode: JavascriptMode.unrestricted,
    //    onWebViewCreated: (WebViewController webViewController) {
     //     _controller = webViewController;
     //   },
   //   ),
 //   );
//  }

  // Construye la URL del mapa satelital
//  String _buildMapUrl() {
 //   return Uri.dataFromString('''
   //   <!DOCTYPE html>
   //   <html>
  //    <head>
   //     <meta name="viewport" content="width=device-width, initial-scale=1.0">
   //     <script src="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas.min.js"></script>
   //     <link rel="stylesheet" href="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas.min.css" type="text/css">
     //   <style>
     //     html, body, #map {
     //       width: 100%;
     //       height: 100%;
    //        margin: 0;
    //        padding: 0;
    //      }
   //     </style>
  //    </head>
  //    <body>
  //      <div id="map"></div>
  //      <script>
    //      let map;
  //        function initializeMap() {
   //         map = new atlas.Map('map', {
   //           center: [-100.5, 20.0],
   // )