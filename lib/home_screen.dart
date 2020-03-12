import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:beacon/hosting_screen.dart';
import 'package:beacon/tracking_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              customButton(
                text: "HOST\nBEACON",
                tag: "host",
                color: Colors.blueAccent,
                screen: HostingScreen(),
              ),
              customButton(
                text: "TRACK\nBEACON",
                tag: "track",
                color: Colors.redAccent,
                screen: TrackingScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customButton({
    @required text,
    @required tag,
    @required color,
    @required screen,
  }) {
    return GestureDetector(
      child: Hero(
        tag: tag,
        child: Container(
          width: size.width / 2,
          height: size.width / 2,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(500),
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (builder) => screen,
        ),
      ),
    );
  }
}
