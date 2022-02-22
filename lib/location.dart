import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Allow your location',
            style: TextStyle(fontSize: 24),
          ),
          Text('We will need your location to find restaurants near you.'),
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
            onPressed: () {},
            child: const Text('Cool button'),
          ),
        ],
      )),
    );
  }
}
