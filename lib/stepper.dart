import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data_files/gua_search_keywords.dart' as keywords;
import 'requester.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'data_files/explore_json.dart';
import 'data_files/gua_globals.dart';
import 'restaurant_list.dart' as rl;

Map<String, String> queryParameters = {
  'term': 'food',
  'latitude': gpsLatitude.toString(),
  'longitude': gpsLongitude.toString(),
};

class StepperPage extends StatefulWidget {
  const StepperPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  void _yelpRequest() async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url =
        Uri.https("api.yelp.com", "/v3/businesses/search", queryParameters);
    var api =
        "CSPBb5_jfbSmHLPjALQ2zoIgKlP2VlSTa6uJJOw3icdkfgnBAbKGypM2X2eatNaohl7EPHDbVD3t0LNXYv1SIvNisq76WkFvTVHGb8LoYuhZaDzjMWoCYMnYBJtMYnYx";

    // print(url);

    // Await the http get response, then decode the json-formatted response.
    var response =
        await http.get(url, headers: {'Authorization': 'Bearer ' + api});
    if (response.statusCode == 200) {
      print(response.statusCode);
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      yelp_json = convert.jsonDecode(response.body) as Map<String, dynamic>;

      Navigator.pushNamed(context, '/list');
    } else {
      print(
          'Request failed with status: ${response.statusCode}. \n  ${response.body}');
    }
  }

  void _cuisineSelect() {
    keywords.foodCat = keywords.foodCat + "Chinese";
    setState(() {});
  }

  String _returnDollars() {
    String s = "";
    String dollar = "\$";
    if (_currentPriceValue == 0) {
      return "No preference";
    }
    for (var i = 0; i < _currentPriceValue; i++) {
      s = s + dollar;
    }
    return s;
  }

  String _returnStars() {
    String s = "";
    String star = "???";
    if (_currentRateValue == 0) {
      return "No preference";
    }
    for (var i = 0; i < _currentRateValue; i++) {
      s = s + star;
    }
    return s;
  }

  String _returnDistance() {
    if (_currentDistValue == 0) {
      return "No preference";
    } else {
      return _currentDistValue.round().toString() + " miles";
    }
  }

  String cuisineValue = "Any Cuisine";
  double _currentPriceValue = 2;
  double _currentDistValue = 1;
  double _currentRateValue = 5;
  bool _openNowValue = false;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200.0,
              height: 30.0,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/explore');
                },
                child: const Text('Demo button. Deprecate.'),
              ),
            ),
            SizedBox(
              width: 200.0,
              height: 30.0,
              child: OutlinedButton(
                onPressed: () {
                  _yelpRequest();
                },
                child: const Text('request test button'),
              ),
            ),
            Stepper(
                physics: const NeverScrollableScrollPhysics(),
                currentStep: _index,
                onStepCancel: () {
                  if (_index > 0) {
                    setState(() {
                      _index -= 1;
                    });
                  }
                },
                onStepContinue: () {
                  if (_index <= 3) {
                    setState(() {
                      _index += 1;
                    });
                  }
                },
                onStepTapped: (int index) {
                  setState(() {
                    _index = index;
                  });
                },
                steps: <Step>[
                  Step(
                    title: const Text('Cuisines'),
                    content: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Text(keywords.foodCat),
                            DropdownButton(
                              value: cuisineValue,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(color: Colors.black),
                              underline: Container(
                                height: 2,
                                color: Colors.black,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  cuisineValue = newValue!;
                                  keywords.foodCat = cuisineValue;
                                  if (keywords.foodCat == "Any Cuisine") {
                                    keywords.foodCat = "";
                                  }
                                });
                              },
                              items: <String>[
                                'Any Cuisine',
                                'American',
                                'Barbecue',
                                'Chinese',
                                'French',
                                'Hamburger',
                                'Indian',
                                'Italian',
                                'Japanese',
                                'Mexican',
                                'Pizza',
                                'Seafood',
                                'Steak',
                                'Sushi',
                                'Thai'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )
                          ],
                        )),
                  ),
                  /*!!! WILL CHANGE TO SORT BY best_match, rating, review_count or distance !!! */
                  // Step(
                  //   title: const Text('Rating'),
                  //   content: Container(
                  //       alignment: Alignment.centerLeft,
                  //       child: Column(
                  //         children: [
                  //           Text(_returnStars()),
                  //           Slider(
                  //             value: _currentRateValue,
                  //             min: 0,
                  //             max: 5,
                  //             divisions: 5,
                  //             onChanged: (double value) {
                  //               setState(() {
                  //                 _currentRateValue = value;
                  //               });
                  //             },
                  //           ),
                  //         ],
                  //       )),
                  // ),
                  Step(
                    title: const Text('Distance'),
                    content: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Text(_returnDistance()),
                            Slider(
                              value: _currentDistValue,
                              min: 0,
                              max: 25,
                              onChanged: (double value) {
                                setState(() {
                                  _currentDistValue = value;
                                });
                              },
                            ),
                          ],
                        )),
                  ),
                  Step(
                    title: const Text('Price Limit'),
                    content: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Text(_returnDollars()),
                            Slider(
                              value: _currentPriceValue,
                              min: 0,
                              max: 4,
                              divisions: 4,
                              label: _returnDollars(),
                              onChanged: (double value) {
                                setState(() {
                                  _currentPriceValue = value;
                                });
                              },
                            ),
                          ],
                        )),
                  ),
                  Step(
                    title: const Text('Open now'),
                    content: Container(
                        alignment: Alignment.centerLeft,
                        child: SwitchListTile(
                          title: const Text('Open now'),
                          value: _openNowValue,
                          onChanged: (bool value) {
                            setState(() {
                              _openNowValue = value;
                            });
                          },
                          secondary: const Icon(Icons.lock_clock),
                        )),
                  ),
                ])
          ],
        ),
      )),
    );
  }
}
