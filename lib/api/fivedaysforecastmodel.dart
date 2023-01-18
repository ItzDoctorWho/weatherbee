class FiveDaysForecast {
  final List<Forecast> list;
  FiveDaysForecast({this.list});
  factory FiveDaysForecast.fromJson(Map<String, dynamic> json) {
    var list = json['list'] as List;
    List<Forecast> forecastList =
        list.map((i) => Forecast.fromJson(i)).toList();
    return FiveDaysForecast(list: forecastList);
  }
}

class Forecast {
  final String date;
  final String weatherStatus;
  final String weatherDescription;
  final String weatherIcon;
  final double temperature;
  final double feelsLike;
  final double minTemperature;
  final double maxTemperature;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final int windDegree;
  final int visibility;
  final int cloudiness;
  final double rainVolume;
  final double snowVolume;
  final double uvi;
  final double latitude;
  final double longitude;
  final int sunrise;
  final int sunset;
  final int timezone;

  Forecast(
      {this.date,
      this.weatherStatus,
      this.weatherDescription,
      this.weatherIcon,
      this.temperature,
      this.feelsLike,
      this.minTemperature,
      this.maxTemperature,
      this.pressure,
      this.humidity,
      this.windSpeed,
      this.windDegree,
      this.visibility,
      this.cloudiness,
      this.rainVolume,
      this.snowVolume,
      this.uvi,
      this.latitude,
      this.longitude,
      this.sunrise,
      this.sunset,
      this.timezone});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      date: json['dt'],
      weatherStatus: json['weather'][0]['main'],
      weatherDescription: json['weather'][0]['description'],
      weatherIcon: json['weather'][0]['icon'],
      temperature: json['main']['temp'],
      feelsLike: json['main']['feels_like'],
      minTemperature: json['main']['temp_min'],
      maxTemperature: json['main']['temp_max'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      windDegree: json['wind']['deg'],
      visibility: json['visibility'],
      cloudiness: json['clouds']['all'],
      rainVolume: json['rain'] != null ? json['rain']['3h'] : 0,
      snowVolume: json['snow'] != null ? json['snow']['3h'] : 0,
      uvi: json['uvi'],
      latitude: json['coord']['lat'],
      longitude: json['coord']['lon'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      timezone: json['timezone'],
    );
  }


}
