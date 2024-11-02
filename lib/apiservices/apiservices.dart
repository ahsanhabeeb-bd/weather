import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/services.dart' show rootBundle;

class Apiservices {
//api key
  final String apikey = '549eaacd79dd4e2a85375345242310';
  final String forecasturl = "http://api.weatherapi.com/v1/forecast.json";

//Current weeather data
  Future<Map<String, dynamic>> currentweather(String searchtext) async {
    final url =
        "$forecasturl?key=$apikey&q=$searchtext&days=7&aqi=no&alerts=no";

    final Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      return jsonDecode(response.body);
    } else {
      throw Exception();
    }
  }

  Future<List<String>> loadJsonData() async {
    List<String> stateNames = [];
    // Load the JSON file from the assets
    String jsonString = await rootBundle.loadString('assets/countries.json');

    // Decode the JSON
    List<dynamic> jsonData = json.decode(jsonString);

    // Create a list to hold all state names

    // Iterate over each country
    for (var country in jsonData) {
      // Check if 'states' key exists and is a list
      if (country['states'] is List) {
        for (var state in country['states']) {
          // Add each state name to the list
          stateNames.add(state['name']);
        }
      }
    }
    stateNames.sort();
    return stateNames;

    // Print all state names
  }
}
