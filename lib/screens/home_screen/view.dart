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
                  prefsInstance.prefs.getString("name") ?? "EDIT NAME",
                  style: textTheme.headline,
                ),
              ],
            ),
            HomeScreenButton(
              text: "CREATE\nROOM",
              color: Colors.redAccent,
              route: null,
              tag: "create",
            ),
            HomeScreenButton(
              text: "JOIN\nROOM",
              color: Colors.blueAccent,
              route: null,
              tag: "join",
            ),
          ],
        ),
      ),
    );
  }
}
