import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'data_files/gua_globals.dart' as gua_globals;
import 'confirm_location.dart';

class StepperPage extends StatefulWidget {
  const StepperPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(),
      )),
    );
  }
}
