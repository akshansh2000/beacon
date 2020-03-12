import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:beacon/home_screen.dart';
import 'package:beacon/name_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';

SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      home: prefs.getString("name") == null ? NameScreen(prefs) : HomeScreen(),
    );
  }
}
