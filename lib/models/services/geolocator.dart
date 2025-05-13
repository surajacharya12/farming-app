import 'package:krishi_sathi/API/weather.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> getLocation() async {
  LocationPermission permission;

  // Check the current permission status
  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  // If permission is denied forever, return an error
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.',
    );
  }

  // Get and return the current position
  return await Geolocator.getCurrentPosition();
}
