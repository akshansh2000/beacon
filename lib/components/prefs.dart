import 'package:shared_preferences/shared_preferences.dart';

PrefsFunctions prefsInstance;

class PrefsFunctions {
  SharedPreferences prefs;

  PrefsFunctions() {
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  updatePrefs(String key, value) {
    switch (value.runtimeType) {
      case int:
        prefs.setInt(key, value);
        break;
      case bool:
        prefs.setBool(key, value);
        break;
      case String:
        prefs.setString(key, value);
        break;
      case double:
        prefs.setDouble(key, value);
        break;
    }
  }
}
