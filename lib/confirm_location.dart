import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:guava_frontend/geocode.dart';
import 'data_files/gua_globals.dart' as gua_globals;

locationConfirmDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Enter location"),
    onPressed: () {
      Navigator.pushReplacementNamed(context, '/geocode');
    },
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed: () {
      Navigator.pushNamed(context, '/stepper');
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Confirm location"),
    content: Text("Is the correct location?\n" +
        // gua_globals.cityName +
        // ", " +
        // gua_globals.stateName +
        // "\n" +
        gua_globals.everything),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
