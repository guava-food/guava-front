import 'package:flutter/material.dart';
import 'package:guava_frontend/stepper.dart';
import 'location.dart';
import 'geocode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guava',
      theme: ThemeData(primarySwatch: Colors.grey),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (BuildContext context) => const MyHomePage(
              title: "Login",
            ),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/location': (BuildContext context) => const LocationPage(
              title: "Location",
            ),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/geocode': (BuildContext context) => const GeocodePage(
              title: "Geocode",
            ),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/stepper': (BuildContext context) => const StepperPage(
              title: "Stepper",
            ),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    void _toggle() {
      setState(() {
        _obscureText = !_obscureText;
      });
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(
                image: NetworkImage('https://i.imgur.com/Xr5Qp7j.png'),
              ),
              const Text(
                'Guava',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: Colors.black54),
              ),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                autocorrect: false,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: _toggle,
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      size: 24.0,
                    ),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 200.0,
                    height: 30.0,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/location');
                      },
                      child: const Text('Login'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 200.0,
                    height: 30.0,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Forgot Password'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
