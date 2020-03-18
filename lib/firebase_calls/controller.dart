import 'package:beacon/components/prefs.dart';

import 'package:firebase_database/firebase_database.dart';

FirebaseController controller;

class FirebaseController {
  DatabaseReference _database;

  FirebaseController() {
    _database = FirebaseDatabase.instance.reference();
  }

  Map createRoom(String roomId) {
    final _roomDetails = {
      "expiry": prefsInstance.prefs.getString("expiry"),
      prefsInstance.prefs.getString("id"): {
        "name": prefsInstance.prefs.getString("name"),
        "mode": "host",
      },
    };

    _database.child(roomId).set(_roomDetails);
    return _roomDetails;
  }
}
