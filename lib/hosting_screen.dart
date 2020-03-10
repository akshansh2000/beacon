import 'package:flutter/material.dart';

class HostingScreen extends StatefulWidget {
  HostingScreen({Key key}) : super(key: key);

  @override
  _HostingScreenState createState() => _HostingScreenState();
}

class _HostingScreenState extends State<HostingScreen> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Hero(
          tag: "host",
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
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
