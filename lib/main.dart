import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:beacon/home_screen.dart';
import 'package:beacon/name_screen.dart';
import 'package:beacon/hosting_screen.dart';
import 'package:beacon/tracking_screen.dart';
import 'package:beacon/map_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uni_links/uni_links.dart';

SharedPreferences prefs;
String initLink;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    initLink = await getInitialLink();
  } on PlatformException {}

  prefs = await SharedPreferences.getInstance();
  FirebaseDatabase.instance
      .reference()
      .child(prefs.getString("lastKey") ?? "")
      .remove();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      systemNavigationBarColor: Colors.black,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'beacon',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        accentColor: Colors.white,
      ),
      onGenerateRoute: (settings) {
        return CupertinoPageRoute(
          builder: (_) {
            switch (settings.name) {
              case '/home':
                return HomeScreen(prefs);
              case '/host':
                return HostingScreen();
              case '/track':
                return TrackingScreen();
              case '/name':
                return NameScreen(prefs);
              case '/map':
                return MapScreen();
            }
          },
        );
      },
      home: prefs.getString("name") == null
          ? NameScreen(prefs)
          : initLink != null
              ? TrackingScreen(initLink: initLink)
              : HomeScreen(prefs),
    );
  }
}
