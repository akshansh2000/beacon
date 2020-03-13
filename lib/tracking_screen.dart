import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:beacon/common_screen.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:location/location.dart';

DatabaseReference databaseReference;
double lat, lon;

class TrackingScreen extends StatefulWidget {
  TrackingScreen({this.initLink, Key key}) : super(key: key);

  final String initLink;

  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  TextEditingController _textEditingController;
  bool isLoading = true, isLoaded = false;
  Size size;
  String beaconName;
  String decodedID;
  RegExp regex =
      RegExp("(?<=^https:\/\/app\.beacon\.cce\/)[A-Za-z0-9+\/]+={0,2}\$");

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    databaseReference = FirebaseDatabase.instance.reference();

    if (widget.initLink != null) {
      decodedID = urlToId(widget.initLink);

      if (!regex.hasMatch(widget.initLink))
        scaffoldState.currentState.showSnackBar(
          SnackBar(
            backgroundColor: Colors.grey[900],
            content: Text(
              "Please enter a valid URL.",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      else
        loadData();
    }

    databaseReference.onValue.listen((data) {
      databaseReference.child(decodedID).once().then((data) {
        setState(() {
          if (data.value == null && isLoaded)
            scaffoldState.currentState.showSnackBar(
              SnackBar(
                backgroundColor: Colors.grey[900],
                content: Text(
                  "Beacon no more available. The location will not update further.",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          else {
            lat = data.value["lat"];
            lon = data.value["lon"];
            beaconName = data.value["name"];
          }
        });
      });
    });

    Timer(Duration(seconds: 1), () {
      if (widget.initLink == null)
        setState(() {
          isLoading = false;
        });
    });
  }

  loadData() {
    databaseReference.child(decodedID).once().then(
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
            isLoading = false;
            lat = data.value["lat"];
            lon = data.value["lon"];
            beaconName = data.value["name"];
          });
        }
      },
    );
  }

  urlToId(String url) {
    return String.fromCharCodes(base64Decode(regex.firstMatch(url).group(0)));
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        showWarning(context, "track", shouldExit: widget.initLink != null);
        return null;
      },
      child: CommonScreen(
        tag: "track",
        color: Colors.redAccent,
        shouldExit: widget.initLink != null,
        child: isLoaded
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "TRACKING\n${beaconName.toUpperCase()}",
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
                          "Show on Map",
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
                            await Location().requestPermission();
                            Navigator.of(context).pushNamed('/map');
                          }),
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
                        "ENTER THE\nBEACON URL",
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
                            child: Theme(
                              data: ThemeData(
                                primaryColor: Colors.white,
                                textSelectionColor: Colors.blueGrey,
                                hintColor: Colors.white,
                              ),
                              child: TextFormField(
                                maxLines: 5,
                                minLines: 1,
                                cursorColor: Colors.white,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                                controller: _textEditingController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
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
                          if (text == null || !regex.hasMatch(text))
                            scaffoldState.currentState.showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.grey[900],
                                content: Text(
                                  "Please enter a valid URL.",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          else {
                            decodedID =
                                urlToId(_textEditingController.value.text);

                            loadData();
                          }
                        },
                      ),
                    ],
                  ),
      ),
    );
  }
}
