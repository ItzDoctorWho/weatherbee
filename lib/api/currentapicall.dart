import 'dart:convert';
import 'package:weatherbee/api/apikey.dart';
import 'package:weatherbee/api/currentweathermodel.dart';
import 'package:http/http.dart' as http;

String baseURL = "api.openweathermap.org";

// ignore: missing_return
Future<bool> checkCityExists(String city, String unit) async {
  final response = await http.get(Uri.http(baseURL, "data/2.5/weather",
      {"q": city, "units": unit, "appid": apiKey}));
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    if (jsonData["cod"] == "200") {
      return true;
    } else {
      return false;
    }
  }
}

Future<CurrentWeather> getCurrentWeather(String city, String unit) async {
  var url = Uri.http("api.openweathermap.org", "data/2.5/weather",
      {"q": city, "units": unit, "appid": apiKey});
  final response = await http.get(url);
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    return CurrentWeather.fromJson(body);
  } else {
    throw Exception('Failed to load weather');
  }
}
