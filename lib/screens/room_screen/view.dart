import 'dart:async';

import 'package:flutter/material.dart';

import 'package:beacon/components/member_list_container.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class RoomScreen extends StatefulWidget {
  RoomScreen({Key key}) : super(key: key);

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  Future<LocationData> _locationData;
  final _mapController = Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 1),
      () => setState(() {
        _locationData = Location().getLocation();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: _locationData,
      builder: (context, snapshot) {
        return !snapshot.hasData || snapshot == null
            ? Scaffold(
                body: Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            : SafeArea(
                child: Scaffold(
                  body: Stack(
                    children: <Widget>[
                      Container(
                        height: size.height * 0.65,
                        width: size.width,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              snapshot.data.latitude,
                              snapshot.data.longitude,
                            ),
                            zoom: 15,
                          ),
                          compassEnabled: true,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          rotateGesturesEnabled: true,
                          scrollGesturesEnabled: true,
                          zoomGesturesEnabled: true,
                          buildingsEnabled: true,
                          trafficEnabled: true,
                          onMapCreated: (controller) =>
                              _mapController.complete(controller),
                        ),
                      ),
                      MemberListContainer(),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
