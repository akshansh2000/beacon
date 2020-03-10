import 'package:flutter/material.dart';

import 'package:beacon/common_screen.dart';

class TrackingScreen extends StatefulWidget {
  TrackingScreen({Key key}) : super(key: key);

  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      tag: "track",
      color: Colors.redAccent,
    );
  }
}
