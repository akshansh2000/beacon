import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreenLocation extends StatefulWidget {
  MapScreenLocation(this.lat, this.lon, {Key key}) : super(key: key);

  final double lat, lon;

  @override
  _MapScreenLocationState createState() => _MapScreenLocationState();
}

class _MapScreenLocationState extends State<MapScreenLocation> {
  Completer _mapController = Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.lat, widget.lon),
          zoom: 15,
        ),
        compassEnabled: true,
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              onMapCreated: (controller) => _mapController.complete(controller),
      ),
    );
  }
}
