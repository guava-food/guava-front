import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'data_files/gua_globals.dart' as gua_globals;
import 'confirm_location.dart';

class GeocodePage extends StatefulWidget {
  const GeocodePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<GeocodePage> createState() => _GeocodePageState();
}

class _GeocodePageState extends State<GeocodePage> {
  final myController = TextEditingController();

  void _savelocation() async {
    String formText = myController.text.toString();

    List<Location> locations = await locationFromAddress(formText);
    gua_globals.gpsLatitude = locations[0].latitude.toDouble();
    gua_globals.gpsLongitude = locations[0].longitude.toDouble();

    List<Placemark> placemarks = await placemarkFromCoordinates(
        gua_globals.gpsLatitude, gua_globals.gpsLongitude);
    gua_globals.cityName = placemarks[0].locality.toString();
    gua_globals.stateName = placemarks[0].administrativeArea.toString();
    gua_globals.countryName = placemarks[0].country.toString();
    gua_globals.everything = placemarks[0].toString();

    setState(() {});
    locationConfirmDialog(context);
  }

  void _formatLatLong() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.search,
              size: 100,
              color: Color.fromARGB(255, 241, 93, 164),
            ),
            const Text(
              'Help us find you instead.',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 5),
            const Text("Enter any location here."),
            TextFormField(
              autocorrect: false,
              controller: myController,
              decoration: const InputDecoration(
                labelText: 'Location',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 200.0,
              height: 30.0,
              child: OutlinedButton(
                onPressed: () {
                  _savelocation();
                  _formatLatLong();
                },
                child: const Text('Find me here'),
              ),
            ),
            const SizedBox(height: 10),
            Text(gua_globals.gpsLatitude.toString() +
                ", " +
                gua_globals.gpsLongitude.toString()),
            const SizedBox(height: 10),
            Text(gua_globals.cityName + ", " + gua_globals.stateName),
          ],
        ),
      )),
    );
  }
}
