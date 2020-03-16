import 'package:flutter/material.dart';

import 'package:beacon/components/home_screen_button.dart';
import 'package:beacon/components/prefs.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  prefsInstance.prefs.getString("name").toUpperCase() ??
                      "EDIT NAME",
                  style: textTheme.headline,
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => Navigator.of(context).pushNamed("/name"),
                ),
              ],
            ),
            HomeScreenButton(
              text: "CREATE\nROOM",
              color: Colors.redAccent,
              route: "/create",
              tag: "create",
            ),
            HomeScreenButton(
              text: "JOIN\nROOM",
              color: Colors.blueAccent,
              route: "/join",
              tag: "join",
            ),
          ],
        ),
      ),
    );
  }
}
