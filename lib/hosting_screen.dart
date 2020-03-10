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

  @override
  void initState() {
    super.initState();

    _databaseReference = FirebaseDatabase.instance.reference();
    getLocation();
  }

  getLocation() async {
    final _locationData = await Location().getLocation();
    hostLocation(_locationData);
  }

  hostLocation(locationData) async {
    final _randomString = randomAlphaNumeric(15);
    _databaseReference.child(_randomString).set({
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
          ? Container()
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
