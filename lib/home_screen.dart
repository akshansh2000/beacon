import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen(this.prefs, {Key key}) : super(key: key);

  final SharedPreferences prefs;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.prefs.getString("name"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    iconSize: 26,
                    onPressed: () =>
                        Navigator.of(context).pushReplacementNamed('/name'),
                  ),
                ],
              ),
              customButton(
                text: "HOST\nBEACON",
                tag: "host",
                color: Colors.blueAccent,
                screen: '/hostOptions',
              ),
              customButton(
                text: "TRACK\nBEACON",
                tag: "track",
                color: Colors.redAccent,
                screen: '/track',
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
      onTap: () => Navigator.of(context).pushNamed(screen),
    );
  }
}
