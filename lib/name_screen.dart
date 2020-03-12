import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:beacon/common_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class NameScreen extends StatefulWidget {
  NameScreen(this.prefs, {Key key}) : super(key: key);

  final SharedPreferences prefs;

  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.prefs.getString("name") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      color: Colors.white,
      tag: "null",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "ENTER YOUR\nNAME",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.black,
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
                    primaryColor: Colors.black,
                  ),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
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
          ),
          SizedBox(height: 50),
          IconButton(
            icon: Icon(Icons.check),
            iconSize: 30,
            color: Colors.black,
            onPressed: () {
              widget.prefs.setString("name", _textEditingController.value.text);

              Navigator.of(context).pushReplacementNamed("/home");
            },
          ),
        ],
      ),
    );
  }
}
