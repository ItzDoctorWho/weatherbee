
class Forecast {
  final int date;
  final String weatherStatus;
  final String weatherDescription;
  final String weatherIcon;
  final num temperature;
  final num feelsLike;
  final num minTemperature;
  final num maxTemperature;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final int windDegree;
  final int visibility;
  final int cloudiness;
  final double rainVolume;
  final double snowVolume;
  final double uvi;

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
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      timezone: json['timezone'],
    );
  }
}
