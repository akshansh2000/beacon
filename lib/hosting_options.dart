import 'package:flutter/material.dart';

import 'package:beacon/common_screen.dart';

class HostingOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      tag: "host",
      color: Colors.blueAccent,
      heightFactor: 1.35,
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
                SizedBox(height: 20),
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
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
      ),
      child: Material(
        elevation: 0,
        color: Colors.transparent,
        child: InkWell(
          highlightColor: Colors.white,
          splashColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          onTap: () => Navigator.of(context).pushReplacementNamed(screen),
        ),
      ),
    );
  }
}

class ExistingBeacon extends StatefulWidget {
  ExistingBeacon({Key key}) : super(key: key);

  @override
  _ExistingBeaconState createState() => _ExistingBeaconState();
}

class _ExistingBeaconState extends State<ExistingBeacon> {
  TextEditingController _textEditingController;
  RegExp regex = RegExp("^[A-Za-z0-9]{15}\$");

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      tag: "host",
      color: Colors.blueAccent,
      heightFactor: 1.5,
      shouldShowDialog: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "ENTER THE\nBEACON ID",
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
          Material(
            color: Colors.transparent,
            child: IconButton(
              icon: Icon(Icons.check),
              iconSize: 30,
              onPressed: () {
                final text = _textEditingController.value.text;
                if (text == null || !regex.hasMatch(text))
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
                else {}
              },
            ),
          ),
        ],
      ),
    );
  }
}
