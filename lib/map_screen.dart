import 'dart:async';

import 'package:flutter/material.dart';

import 'package:beacon/tracking_screen.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer _mapController = Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Event>(
        initialData: null,
        stream: databaseReference.onValue,
        builder: (context, snapshot) {
          return SafeArea(
            child: Stack(
              children: <Widget>[
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(lat, lon),
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId("beacon"),
                      position: LatLng(lat, lon),
                    ),
                  },
                  compassEnabled: true,
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                ),
              ],
            ),
          );
        });
  }
}
