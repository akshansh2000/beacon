import 'package:flutter/material.dart';

import 'package:beacon/common_screen.dart';

class HostingScreen extends StatefulWidget {
  HostingScreen({Key key}) : super(key: key);

  @override
  _HostingScreenState createState() => _HostingScreenState();
}

class _HostingScreenState extends State<HostingScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      tag: "host",
      color: Colors.blueAccent,
    );
  }
}
