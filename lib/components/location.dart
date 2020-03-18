import 'package:location/location.dart';

CustomLocationData locationData;

class CustomLocationData {
  double lat, lon;
  LocationData data;
  Location location;

  CustomLocationData() {
    location = Location();
    getLocation();

    location.onLocationChanged().listen((locationData) {
      data = locationData;

      lat = data.latitude;
      lon = data.longitude;
    });
  }

  getLocation() async {
    data = await Location().getLocation();

    lat = data.latitude;
    lon = data.longitude;
  }
}
