import 'package:flutter/material.dart';

class TrackingScreen extends StatefulWidget {
  TrackingScreen({Key key}) : super(key: key);

  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Hero(
          tag: "track",
          child: Container(
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(20),
            ),
            width: size.width / 1.2,
            height: size.height / 1.2,
          ),
        ),
      ),
    );
  }
}
