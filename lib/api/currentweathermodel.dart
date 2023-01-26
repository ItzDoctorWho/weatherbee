class CurrentWeather {
  final String cityName;
  final String weatherStatus;
  final String weatherDescription;
  final String weatherIcon;
  final num temperature;
  final num feelsLike;
  final num minTemperature;
  final num maxTemperature;
  final num pressure;
  final num humidity;
  final num windSpeed;
  final num windDegree;
  final int visibility;
  final int cloudiness;
  final num rainVolume;
  final num snowVolume;
  final double uvi;
  final int sunrise;
  final int sunset;
  final int timezone;
  final int date;

  CurrentWeather(
      {this.cityName,
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
      this.timezone,
      this.date});

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      cityName: json['name'],
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
      rainVolume: json['rain'] == null ? 0 : json['rain']['1h'],
      snowVolume: json['snow'] == null ? 0 : json['snow']['1h'],
      uvi: json['uvi'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      timezone: json['timezone'],
      date: json['dt'],
    );
  }
}
