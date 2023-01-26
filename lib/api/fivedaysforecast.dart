import 'dart:convert';
import 'package:weatherbee/api/apikey.dart';
import 'package:http/http.dart' as http;
import 'package:weatherbee/api/fivedaysforecastmodel.dart';

Future<List<Forecast>> getfivedaysWeather(String city, String unit) async {
  var url = Uri.http("api.openweathermap.org", "data/2.5/forecast",
      {"q": city, "appid": apiKey, "units": unit});
  final response = await http.get(url);
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    List<Forecast> forecasts = [];
    Set<String> seenDates = Set();
    for (var item in body['list']) {
      String date = item['dt_txt'].substring(0, 10);

      if (!seenDates.contains(date)) {
        forecasts.add(Forecast.fromJson(item));
        seenDates.add(date);
      }
    }
    return forecasts.sublist(1);
  } else {
    throw Exception('Failed to load weather');
  }
}
