import 'package:beacon/components/location.dart';
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
        "lat": locationData.lat,
        "lon": locationData.lon,
      },
    };

    _database.child(roomId).set(_roomDetails);
    return _roomDetails;
  }

  Map joinRoom(String roomId) {
    Map<String, dynamic> _roomDetails;

    _database.child(roomId).child(prefsInstance.prefs.getString("id")).set({
      "name": prefsInstance.prefs.getString("name"),
      "mode": "listener",
      "lat": locationData.lat,
      "lon": locationData.lon,
    });

    _database
        .child(roomId)
        .once()
        .then((snapshot) => _roomDetails = snapshot.value);

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
              value["mode"] = key == memberId ? "host" : "listener";
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

  void updateLocation(String roomId) {
    _database
        .child("$roomId/${prefsInstance.prefs.getString("id")}/lat")
        .set(locationData.lat);
    _database
        .child("$roomId/${prefsInstance.prefs.getString("id")}/lon")
        .set(locationData.lon);
  }

  void deleteRoom(String roomId) {
    _database.child(roomId).remove();
  }
}
