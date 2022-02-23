import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  double gps_latitude = -1.11;
  double gps_longitude = -1.11;

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
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    print("succssfully allowed");
    return await Geolocator.getCurrentPosition();
  }

  void _savePosition() async {
    Position position = await _determinePosition();

    setState(() {
      gps_latitude = position.latitude.toDouble();
      gps_longitude = position.longitude.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(
              flex: 3,
            ),
            const Icon(Icons.satellite),
            const SizedBox(
              child: Text(
                'Allow your location',
                style: TextStyle(fontSize: 30),
              ),
            ),
            const Text(
              'We will need your location to\nfind restaurants near you.',
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            OutlinedButton(
              onPressed: () {
                //_determinePosition();
              },
              child: const Text('Allow location'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Skip'),
            ),
            OutlinedButton(
              onPressed: () {
                _savePosition();
              },
              child: const Text('Cool button'),
            ),
            Spacer(),
            Text(gps_latitude.toString() + ", " + gps_longitude.toString()),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      )),
    );
  }
}
