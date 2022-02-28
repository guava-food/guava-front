import 'package:flutter/material.dart';

class GeocodePage extends StatefulWidget {
  const GeocodePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<GeocodePage> createState() => _GeocodePageState();
}

class _GeocodePageState extends State<GeocodePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
