import 'package:flutter/material.dart';
import 'data_files/explore_json.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

int test = 1;

class _RestaurantPageState extends State<RestaurantPage> {
  static String title = 'Restaurant List ' + test.toString();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: Text(title), actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                test++;
              });
            },
          ),
        ]),
        body: ListView.builder(
          itemCount: yelp_json["businesses"].length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(yelp_json["businesses"][index]["name"]),
            );
          },
        ),
      ),
    );
  }
}
