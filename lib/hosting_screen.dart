import 'dart:async';

import 'package:flutter/material.dart';

import 'package:beacon/common_screen.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:random_string/random_string.dart';
import 'package:location/location.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HostingScreen extends StatefulWidget {
  HostingScreen({Key key}) : super(key: key);

  @override
  _HostingScreenState createState() => _HostingScreenState();
}

class _HostingScreenState extends State<HostingScreen> {
  DatabaseReference _databaseReference;
  bool _isHosted = false;
  Size size;
  String _randomKey;
  Location location;
  LocationData locationData;
  StreamSubscription<LocationData> _locationDataStream;
  SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();

    _databaseReference = FirebaseDatabase.instance.reference();
    location = Location();
    _randomKey = randomAlphaNumeric(15);
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
    _databaseReference.child(_randomKey).remove();
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
                            "Open in Maps",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          iconSize: 26,
                          onPressed: () async {
                            final urlString =
                                "https://www.google.com/maps/search/?api=1&query=${locationData.latitude},${locationData.longitude}";
                            if (await canLaunch(urlString))
                              await launch(urlString);
                            else
                              throw "Could not load map";
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
                            "$_randomKey",
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
                            ClipboardManager.copyToClipBoard(_randomKey);
                            scaffoldState.currentState.showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.grey[900],
                                content: Text(
                                  "Copied to clipboard!",
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
