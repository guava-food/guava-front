import 'package:flutter/material.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("data"),
            Stepper(steps: <Step>[
              Step(
                title: const Text('Step 1 title'),
                content: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text('Content for Step 1')),
              ),
              const Step(
                title: Text('Step 2 title'),
                content: Text('Content for Step 2'),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
