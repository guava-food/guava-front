import 'package:flutter/material.dart';
import 'data_files/gua_search_keywords.dart' as keywords;

class StepperPage extends StatefulWidget {
  const StepperPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
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
                        child: const Text('Content for Step 1')),
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
                        child: const Text('to be implemented.')),
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
