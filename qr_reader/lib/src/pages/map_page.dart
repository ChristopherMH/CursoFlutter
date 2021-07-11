import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final token =
      'pk.eyJ1IjoidXJpZWxleGlzNjQiLCJhIjoiY2treW5zd3BiMDg4dzJvcGx3OWYyZ201dyJ9.vFWYPMn2ZPKRA6hWfdXUMQ';

  final mapController = new MapController();

  int _styleIdIndex = 0;

  final List<String> _styles = [
    'streets-v11',
    'outdoors-v11',
    'light-v10',
    'dark-v10',
    'satellite-streets-v11',
    'satellite-v9'
  ];

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Location'),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              mapController.moveAndRotate(scan.getLatLng(), 18, 0);
            },
          )
        ],
      ),
      body: _createFlutterMap(scan),
      floatingActionButton: _createFloatingButton(context),
    );
  }

  Widget _createFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
          center: scan.getLatLng(), zoom: 18.0, minZoom: 2, maxZoom: 30.0),
      layers: [_createMap(), _createMarkers(scan)],
    );
  }

  TileLayerOptions _createMap() {
    return TileLayerOptions(
        urlTemplate:
            'https://api.mapbox.com/styles/v1/mapbox/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
        additionalOptions: {
          'accessToken': token,
          "id": '${_styles[_styleIdIndex]}'
        });
  }

  _createMarkers(ScanModel scan) {
    return MarkerLayerOptions(markers: [
      Marker(
          width: 100,
          height: 100,
          point: scan.getLatLng(),
          builder: (context) => Container(
                  child: Icon(
                Icons.location_on,
                size: 70,
                color: Theme.of(context).primaryColor,
              )))
    ]);
  }

  Widget _createFloatingButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        setState(() {
          if (_styleIdIndex == _styles.length - 1) {
            _styleIdIndex = 0;
          } else {
            _styleIdIndex++;
          }
        });
      },
    );
  }
}
