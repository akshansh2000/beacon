import 'package:flutter/material.dart';

import 'package:beacon/common_screen.dart';
import 'package:beacon/hosting_screen.dart';

class HostingOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      tag: "host",
      color: Colors.blueAccent,
      shouldShowDialog: false,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "WHAT DO YOU\nWANT TO DO?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                decoration: TextDecoration.none,
                color: Colors.white,
                fontFamily: "Roboto",
              ),
            ),
            Column(
              children: <Widget>[
                customButton("HOST NEW BEACON", '/host', context),
                SizedBox(height: 10),
                customButton("USE EXISTING BEACON", '/useExisting', context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget customButton(text, screen, context) {
    return Container(
      child: Material(
        elevation: 10,
        color: Colors.white,
        borderRadius: BorderRadius.circular(500),
        child: InkWell(
          borderRadius: BorderRadius.circular(500),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () => Navigator.of(context).pushReplacementNamed(screen),
        ),
      ),
    );
  }
}
