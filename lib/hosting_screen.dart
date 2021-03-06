import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

import 'package:beacon/common_screen.dart';
import 'package:beacon/map_screen_location.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:random_string/random_string.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HostingScreen extends StatefulWidget {
  HostingScreen({this.beaconKey, Key key}) : super(key: key);

  final String beaconKey;

  @override
  _HostingScreenState createState() => _HostingScreenState();
}

class _HostingScreenState extends State<HostingScreen> {
  DatabaseReference _databaseReference;
  bool _isHosted = false;
  Size size;
  String _randomKey;
  String finalUrl;
  Location location;
  LocationData locationData;
  StreamSubscription<LocationData> _locationDataStream;
  SharedPreferences _prefs;
  bool didTransfer = false;

  @override
  void initState() {
    super.initState();

    _databaseReference = FirebaseDatabase.instance.reference();
    location = Location();
    _randomKey =
        widget.beaconKey == null ? randomAlphaNumeric(15) : widget.beaconKey;
    finalUrl = "https://app.beacon.cce/" +
        base64Encode(Utf8Encoder().convert(_randomKey));
    getLocation();
  }

  getLocation() async {
    locationData = await location.getLocation();
    _prefs = await SharedPreferences.getInstance();

    _prefs.setString("lastKey", _randomKey);
    hostLocation();

    _locationDataStream =
        location.onLocationChanged().listen((locationDetails) {
      locationData = locationDetails;
      hostLocation();
    });
  }

  hostLocation() async {
    _databaseReference.child(_randomKey).set({
      "name": _prefs.getString("name") ?? "Anonymous",
      "lat": locationData.latitude,
      "lon": locationData.longitude,
    });

    setState(() {
      _isHosted = true;
    });
  }

  @override
  void dispose() {
    if (!didTransfer) _databaseReference.child(_randomKey).remove();
    _locationDataStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        showWarning(context, "host");
        return null;
      },
      child: CommonScreen(
        tag: "host",
        color: Colors.blueAccent,
        child: _isHosted
            ? Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "BEACON\nHOSTED",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.location_on,
                            size: 30,
                          ),
                        ),
                        Text(
                          "${locationData.latitude.toStringAsFixed(4)}, "
                          "${locationData.longitude.toStringAsFixed(4)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Show on Map",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          iconSize: 26,
                          onPressed: () => Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (_) => MapScreenLocation(
                                locationData.latitude,
                                locationData.longitude,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Beacon Follow URL",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.content_copy),
                          iconSize: 26,
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: finalUrl));
                            scaffoldState.currentState.showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.grey[900],
                                content: Text(
                                  "Copied URL to clipboard!",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Transfer Beacon",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          iconSize: 26,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.grey[900],
                                  title: Text("Are you sure?"),
                                  content: Text(
                                      "Do you really want to transfer the beacon? "
                                      "You will lose control of the beacon.\n\n"
                                      "Share the beacon ID with the person you want to transfer the beacon to."),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text("Cancel"),
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        Clipboard.setData(
                                          ClipboardData(text: _randomKey),
                                        );

                                        didTransfer = true;
                                        _prefs.setString("lastKey", "");

                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Copy ID and Proceed"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : Center(
                child: Container(
                  width: size.width / 5,
                  height: size.width / 5,
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }
}
