import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:beacon/screens/home_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String initLink;
  try {
    initLink = await getInitialLink();
  } on PlatformException {}

  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs));
}

class MyApp extends StatelessWidget {
  const MyApp(this.prefs, {Key key}) : super(key: key);

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.black,
    ));

    return MaterialApp(
      title: "beacon",
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),
      onGenerateRoute: (settings) {
        return CupertinoPageRoute(
          builder: (_) {
            switch (settings.name) {
              case "/home":
                return HomeScreen(prefs);
            }
          },
        );
      },
      home: HomeScreen(prefs),
    );
  }
}
