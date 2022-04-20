import 'package:flutter/material.dart';
import 'data_files/gua_globals.dart' as gua_globals;
import 'data_files/explore_json.dart';

locationConfirmDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Enter location"),
    onPressed: () {
      Navigator.pushReplacementNamed(context, '/geocode');
      yelp_json = {};
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Continue"),
    onPressed: () {
      Navigator.pushNamed(context, '/stepper');
      yelp_json = {};
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Confirm location"),
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
