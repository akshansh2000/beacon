import '../components/prefs.dart';
import '../screens/room_screen/bloc.dart';
import '../screens/room_screen/event.dart';

import 'package:location/location.dart';

CustomLocationData locationData;

class CustomLocationData {
  double lat, lon;
  LocationData _data;
  Location _location;
  bool shouldUpdate = false;

  CustomLocationData() {
    _location = Location();
    getLocation();

    _location.onLocationChanged().listen((_locationData) {
      _data = _locationData;

      lat = _data.latitude;
      lon = _data.longitude;

      bloc.roomDetails[prefsInstance.prefs.getString("id")]["lat"] =
          locationData.lat;
      bloc.roomDetails[prefsInstance.prefs.getString("id")]["lon"] =
          locationData.lon;

      if (shouldUpdate) bloc.input.add(UpdateLocation());
    });
  }

  getLocation() async {
    _data = await Location().getLocation();

    lat = _data.latitude;
    lon = _data.longitude;
  }
}
