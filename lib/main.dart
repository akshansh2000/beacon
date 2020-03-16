import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:beacon/screens/home_screen.dart';

import 'package:uni_links/uni_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String initLink;
  try {
    initLink = await getInitialLink();
  } on PlatformException {}

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

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
      debugShowCheckedModeBanner: false,
      title: "beacon",
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        buttonColor: Colors.transparent,
        splashColor: Colors.transparent,
        textTheme: TextTheme(
          button: TextStyle(
            color: Colors.white,
            decoration: TextDecoration.none,
            fontSize: 20,
            fontFamily: "Roboto",
          ),
        ),
      ),
      onGenerateRoute: (settings) {
        return CupertinoPageRoute(
          builder: (_) {
            switch (settings.name) {
              case "/home":
                return HomeScreen();
            }
          },
        );
      },
      home: HomeScreen(),
    );
  }
}
