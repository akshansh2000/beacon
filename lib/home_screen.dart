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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              child: Hero(
                tag: "host",
                child: Container(
                  width: size.width / 4,
                  height: size.width / 4,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(500),
                  ),
                  child: Center(
                    child: Text(
                      "HOST",
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () => Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (builder) => HostingScreen(),
                ),
              ),
            ),
            GestureDetector(
              child: Hero(
                tag: "track",
                child: Container(
                  width: size.width / 4,
                  height: size.width / 4,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(500),
                  ),
                  child: Center(
                    child: Text(
                      "TRACK",
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () => Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (builder) => TrackingScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
