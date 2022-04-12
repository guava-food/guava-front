import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data_files/gua_search_keywords.dart' as keywords;

class StepperPage extends StatefulWidget {
  const StepperPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  void _cuisineSelect() {
    keywords.foodCat = keywords.foodCat + "Chinese";
    setState(() {});
  }

  String cuisineValue = "Any Cuisine";
  double priceValue = 1;
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
                child: const Text('Find me here'),
              ),
            ),
            Stepper(
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
                  Step(
                    title: const Text('Rating'),
                    content: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text('to be implemented.')),
                  ),
                  Step(
                    title: const Text('Distance'),
                    content: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text('to be implemented.')),
                  ),
                  Step(
                    title: const Text('Price'),
                    content: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Slider(
                                divisions: 5,
                                value: priceValue,
                                onChanged: (double value) {
                                  priceValue = value;
                                })
                          ],
                        )),
                  ),
                  Step(
                    title: const Text('Open now'),
                    content: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text('to be implemented.')),
                  ),
                ])
          ],
        ),
      )),
    );
  }
}
