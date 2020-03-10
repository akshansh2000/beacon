import 'package:flutter/material.dart';

import 'package:beacon/common_screen.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:random_string/random_string.dart';
import 'package:location/location.dart';

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
  LocationData locationData;

  @override
  void initState() {
    super.initState();

    _databaseReference = FirebaseDatabase.instance.reference();
    getLocation();
  }

  getLocation() async {
    locationData = await Location().getLocation();
    hostLocation();
  }

  hostLocation() async {
    final _localRandomKey =
        _randomKey == null ? randomAlphaNumeric(15) : _randomKey;
    _randomKey = _localRandomKey;

    _databaseReference.child(_localRandomKey).set({
      "lat": locationData.latitude,
      "lon": locationData.longitude,
    });

    setState(() {
      _isHosted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return CommonScreen(
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
                      fontSize: 50,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.location_on,
                          size: 40,
                        ),
                      ),
                      Text(
                        "${locationData.latitude.toStringAsFixed(4)}, "
                        "${locationData.longitude.toStringAsFixed(4)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
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
                            fontSize: 30,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        iconSize: 30,
                        onPressed: () {},
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
                            fontSize: 30,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.content_copy),
                        iconSize: 30,
                        onPressed: () {},
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
    );
  }
}
