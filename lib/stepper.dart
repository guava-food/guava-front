import 'package:flutter/material.dart';

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
                    title: const Text('Step 1 title'),
                    content: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text('Content for Step 1')),
                  ),
                  Step(
                    title: const Text('Step 2 title'),
                    content: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text('Content for Step 2')),
                  ),
                  Step(
                    title: const Text('Step 3 title'),
                    content: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text('Content for Step 3')),
                  ),
                  Step(
                    title: const Text('Step 4 title'),
                    content: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text('Content for Step 4')),
                  ),
                  Step(
                    title: const Text('Step 5 title'),
                    content: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text('Content for Step 4')),
                  ),
                ])
          ],
        ),
      )),
    );
  }
}
