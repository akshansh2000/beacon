import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:beacon/components/prefs.dart';
import 'package:beacon/components/theme.dart';
import 'package:beacon/screens/create_room_screen.dart';
import 'package:beacon/screens/home_screen.dart';
import 'package:beacon/screens/join_room_screen.dart';
import 'package:beacon/screens/name_screen.dart';
import 'package:beacon/screens/room_screen/view.dart';

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
      theme: appTheme,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) {
            switch (settings.name) {
              case "/home":
                return HomeScreen();
              case "/name":
                return NameScreen();
              case "/join":
                return JoinRoomScreen();
              case "/create":
                return CreateRoomScreen();
              case "/room":
                return RoomScreen();
            }
          },
        );
      },
      home: prefsInstance.prefs.getString("name") == null
          ? NameScreen(shouldPop: false)
          : HomeScreen(),
    );
  }
}
