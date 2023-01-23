import 'package:geolocator/geolocator.dart';
import 'package:geocode/geocode.dart';

import '../constraints/constants.dart';

class Location {
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      lat = position.latitude;
      long = position.longitude;
    } catch (e) {
      print(e);
    }
  }

  GeoCode geoCode = GeoCode();
  Future<void> getCityLoc(String cityName) async {
    print(lat);
    Coordinates coordinates = await geoCode.forwardGeocoding(address: cityName);
    lat = coordinates.latitude!;
    long = coordinates.longitude!;
    print(cityName);
    print(lat);
  }
}
