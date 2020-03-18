import 'dart:async';

import 'package:flutter/material.dart';

import 'package:beacon/components/custom_dialog.dart';
import 'package:beacon/components/member_list_container.dart';
import 'package:beacon/components/location.dart';
import 'package:beacon/components/prefs.dart';
import 'package:beacon/screens/room_screen/bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class RoomScreen extends StatefulWidget {
  RoomScreen({Key key}) : super(key: key);

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final _mapController = Completer<GoogleMapController>();
  bool shouldLoad = true;

  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 1),
      () async {
        setState(() {
          shouldLoad = false;
        });
      },
    );
  }

  onWillPop() {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          bloc.roomDetails[prefsInstance.prefs.getString("id")]["mode"] ==
                  "host"
              ? "This room will be exited and deleted."
              : "This room will be exited.",
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return shouldLoad
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
            child: WillPopScope(
              onWillPop: () {
                onWillPop();
                return null;
              },
              child: Scaffold(
                body: Stack(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.65,
                      width: size.width,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            locationData.lat,
                            locationData.lon,
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
            ),
          );
  }
}
