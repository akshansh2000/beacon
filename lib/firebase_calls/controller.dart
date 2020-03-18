import 'package:beacon/components/prefs.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseController controller;

class FirebaseController {
  DatabaseReference _database;
  SharedPreferences _prefs;

  FirebaseController() {
    _database = FirebaseDatabase.instance.reference();
    _prefs = prefsInstance.prefs;
  }

  createRoom(String roomId) {
    _database.child(roomId).set({
      "expiry": _prefs.getString("expiry"),
      _prefs.getString("id"): {
        "name": _prefs.getString("name"),
        "mode": "host",
      },
    });
  }
}
