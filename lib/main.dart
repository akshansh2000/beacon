import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:beacon/init.dart';
import 'package:beacon/components/prefs.dart';

import 'package:uni_links/uni_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefsInstance = PrefsFunctions();

  String initLink;
  try {
    initLink = await getInitialLink();
  } on PlatformException {}

  runApp(MyApp());
}
