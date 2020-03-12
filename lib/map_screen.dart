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
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return StreamBuilder<Event>(
      initialData: null,
      stream: databaseReference.onValue,
      builder: (context, snapshot) {
        return SafeArea(
          child: Scaffold(
            body: GoogleMap(
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
              onMapCreated: (controller) => _mapController.complete(controller),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.redAccent,
              onPressed: () async {
                final controller = await _mapController.future;

                controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(lat, lon),
                      zoom: 15,
                    ),
                  ),
                );
              },
              child: Center(
                child: Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
