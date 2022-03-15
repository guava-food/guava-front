import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'confirm_location.dart';
import 'data_files/gua_globals.dart' as gua_globals;

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  bool _locationSuccess = false;

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      Navigator.pushNamed(context, '/geocode');
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    _locationSuccess = true;
    return await Geolocator.getCurrentPosition();
  }

  void _savePosition() async {
    Position position = await _determinePosition();

    gua_globals.gpsLatitude = position.latitude.toDouble();
    gua_globals.gpsLongitude = position.longitude.toDouble();

    List<Placemark> placemarks = await placemarkFromCoordinates(
        gua_globals.gpsLatitude, gua_globals.gpsLongitude);
    gua_globals.cityName = placemarks[0].locality.toString();
    gua_globals.stateName = placemarks[0].administrativeArea.toString();
    gua_globals.countryName = placemarks[0].country.toString();
    gua_globals.everything = placemarks[0].toString();

    setState(() {});
    await Future.delayed(const Duration(milliseconds: 500));
    locationConfirmDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.pin_drop_sharp,
            size: 100,
            color: Color.fromARGB(255, 241, 93, 164),
          ),
          const Text(
            'Allow your location',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 5),
          const Text(
              'We will need your location to find restaurants near you.'),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: 200.0,
                height: 30.0,
                child: OutlinedButton(
                  onPressed: () {
                    _savePosition();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Allow location'),
                      const SizedBox(
                        width: 2,
                      ),
                      if (_locationSuccess)
                        const Icon(
                          Icons.check,
                          size: 15,
                          color: Color.fromARGB(255, 94, 184, 62),
                        )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 200.0,
                height: 30.0,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/geocode');
                  },
                  child: const Text('Skip'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 200.0,
                height: 30.0,
                child: Text(
                    gua_globals.gpsLatitude.toString() +
                        ", " +
                        gua_globals.gpsLongitude.toString(),
                    textAlign: TextAlign.center),
              )
            ],
          ),
        ],
      )),
    );
  }
}
