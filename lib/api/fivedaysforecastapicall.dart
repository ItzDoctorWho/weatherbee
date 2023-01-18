import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherbee/api/apikey.dart';
import 'package:weatherbee/api/fivedaysforecastmodel.dart';

Future<FiveDaysForecast> getFiveDaysForecast() async {
  var url = Uri.http("api.openweathermap.org", "data/2.5/forecast",
      {"q": "monastir", "appid": apiKey, "units": "metric"});
  final response = await http.get(url);
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    return FiveDaysForecast.fromJson(body);
  } else {
    throw Exception('Failed to load weather');
  }
}
