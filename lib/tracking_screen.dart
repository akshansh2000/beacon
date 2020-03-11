import 'dart:async';

import 'package:flutter/material.dart';

import 'package:beacon/common_screen.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackingScreen extends StatefulWidget {
  TrackingScreen({Key key}) : super(key: key);

  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  TextEditingController _textEditingController;
  bool isLoading = true, isLoaded = false;
  Size size;
  DatabaseReference _databaseReference;
  double lat, lon;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _databaseReference = FirebaseDatabase.instance.reference();

    Timer(Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return CommonScreen(
      tag: "track",
      color: Colors.redAccent,
      child: isLoaded
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "TRACKING\nBEACON",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.location_on,
                        size: 30,
                      ),
                    ),
                    Text(
                      "${lat.toStringAsFixed(4)}, "
                      "${lon.toStringAsFixed(4)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
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
                          fontSize: 24,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      iconSize: 26,
                      onPressed: () async {
                        final urlString =
                            "https://www.google.com/maps/search/?api=1&query=$lat,$lon";
                        if (await canLaunch(urlString))
                          await launch(urlString);
                        else
                          throw "Could not load map";
                      },
                    ),
                  ],
                ),
              ],
            )
          : isLoading
              ? Center(
                  child: Container(
                    width: size.width / 5,
                    height: size.width / 5,
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "ENTER YOUR\nFRIEND'S ID",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontFamily: "Roboto",
                      ),
                    ),
                    SizedBox(height: 100),
                    Center(
                      child: Material(
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24),
                            controller: _textEditingController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    IconButton(
                      icon: Icon(Icons.check),
                      iconSize: 30,
                      onPressed: () {
                        final text = _textEditingController.value.text;
                        if (text == null ||
                            !RegExp("^[a-z|A-Z|\\d]{15}\$").hasMatch(text))
                          scaffoldState.currentState.showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.grey[900],
                              content: Text(
                                "Please enter a valid ID.",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        else {
                          _databaseReference
                              .child(_textEditingController.value.text)
                              .once()
                              .then(
                            (DataSnapshot data) {
                              if (data.value == null)
                                scaffoldState.currentState.showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.grey[900],
                                    content: Text(
                                      "Looks like no one is sharing their location with this ID, yet. Are you sure you entered the correct ID?",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              else {
                                setState(() {
                                  isLoaded = true;
                                  lat = data.value["lat"];
                                  lon = data.value["lon"];
                                });
                              }
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
    );
  }
}
