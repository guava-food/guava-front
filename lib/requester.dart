import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void _yelpRequest() async {
  // This example uses the Google Books API to search for books about http.
  // https://developers.google.com/books/docs/overview
  var url = Uri.http(
      "api.yelp.com",
      "/v3/businesses/search/?term=food&latitude=26.11184&longitude=-97.168126",
      {"q": "dart"});

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var itemCount = jsonResponse['totalItems'];
    print('Number of items about http: $itemCount.');
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}
