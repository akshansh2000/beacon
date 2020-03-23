import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'init.dart';
import 'components/location.dart';
import 'components/prefs.dart';
import 'firebase_calls/controller.dart';
import 'screens/room_screen/bloc.dart';

import 'package:location/location.dart';
import 'package:uni_links/uni_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Location().requestPermission();

  prefsInstance = PrefsFunctions();
  controller = FirebaseController();
  bloc = FirebaseBloc();
  locationData = CustomLocationData();

  String initLink;
  try {
    initLink = await getInitialLink();
  } on PlatformException {}

  runApp(MyApp());
}
