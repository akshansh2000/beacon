import 'dart:async';

import 'package:flutter/material.dart';

import 'package:beacon/common_screen.dart';

class TrackingScreen extends StatefulWidget {
  TrackingScreen({Key key}) : super(key: key);

  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  TextEditingController _textEditingController;
  bool isLoading = true;
  Size size;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();

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
      child: isLoading
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
                    fontSize: 50,
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
                  iconSize: 40,
                  onPressed: () {},
                ),
              ],
            ),
    );
  }
}
