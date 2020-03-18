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

  Map setHost(String roomId, String memberId) {
    Map<String, dynamic> _roomDetails;

    _database.child(roomId).once().then(
      (snapshot) {
        _roomDetails = snapshot.value;

        _roomDetails.forEach(
          (key, value) {
            if (key != "expiry") {
              _roomDetails[key]["mode"] = key == memberId ? "host" : "listener";
            }
          },
        );

        _database.child(roomId).set(_roomDetails);
      },
    );

    return _roomDetails;
  }

  Map getDetails(String roomId) {
    Map<String, dynamic> _roomDetails;

    _database
        .child(roomId)
        .once()
        .then((snapshot) => _roomDetails = snapshot.value);

    return _roomDetails;
  }
}
