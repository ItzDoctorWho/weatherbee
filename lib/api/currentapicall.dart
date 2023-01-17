import 'dart:convert';
import 'package:weatherbee/api/apikey.dart.gitignore';
import 'package:weatherbee/api/currentweathermodel.dart';
import 'package:http/http.dart' as http;

String baseURL = "https://api.openweathermap.org";
String settingsURL = "q=monastir&appid=$apiKey";
String city = "monastir";

//city existence check
Future<bool> checkCityExists(String city) async {
  final response = await http.get(Uri.http("api.openweathermap.org",
      "data/2.5/weather", {"q": city, "appid": apiKey, "units": "metric"}));
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    if (jsonData["cod"] == "200") {
      return true;
    } else {
      return false;
    }
  }
}

Future<CurrentWeather> getCurrentWeather(String city) async {
  var url = Uri.http("api.openweathermap.org", "data/2.5/weather",
      {"q": city, "appid": apiKey, "units": "metric"});
  final response = await http.get(url);
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    return CurrentWeather.fromJson(body);
  } else {
    throw Exception('Failed to load weather');
  }
}
