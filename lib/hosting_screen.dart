import 'package:flutter/material.dart';

import 'package:beacon/common_screen.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:random_string/random_string.dart';

class HostingScreen extends StatefulWidget {
  HostingScreen({Key key}) : super(key: key);

  @override
  _HostingScreenState createState() => _HostingScreenState();
}

class _HostingScreenState extends State<HostingScreen> {
  DatabaseReference _databaseReference;
  bool _isHosted = false;

  @override
  void initState() {
    super.initState();

    _databaseReference = FirebaseDatabase.instance.reference();
    hostDatabase();
  }

  hostDatabase() async {
    _databaseReference.child(randomString(15)).set({
      "lat": 23,
      "lon": 23,
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      tag: "host",
      color: Colors.blueAccent,
      child: _isHosted ? Container() : CircularProgressIndicator(),
    );
  }
}
