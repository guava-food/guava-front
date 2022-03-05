import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class GeocodePage extends StatefulWidget {
  const GeocodePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<GeocodePage> createState() => _GeocodePageState();
}

class _GeocodePageState extends State<GeocodePage> {
  double gps_latitude = -1.11;
  double gps_longitude = -1.11;
  final myController = TextEditingController();

  void _savelocation() async {
    String formText = myController.text.toString();

    List<Location> locations = await locationFromAddress(formText);
    setState(() {
      gps_latitude = locations[0].latitude.toDouble();
      gps_longitude = locations[0].longitude.toDouble();
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
            Text("Enter any location here."),
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
                  Navigator.pushNamed(context, '/stepper');
                },
                child: const Text('Find me here'),
              ),
            ),
            const SizedBox(height: 10),
            Text(gps_latitude.toString() + ", " + gps_longitude.toString()),
          ],
        ),
      )),
    );
  }
}
