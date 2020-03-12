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
    GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

    return StreamBuilder<Event>(
      initialData: null,
      stream: databaseReference.onValue,
      builder: (context, snapshot) {
        if (snapshot.data.snapshot.value == null)
          _scaffoldState.currentState.showSnackBar(
            SnackBar(
              backgroundColor: Colors.grey[900],
              content: Text(
                "Beacon no more available. The location will not update further.",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );

        return SafeArea(
          child: Scaffold(
            key: _scaffoldState,
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
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
