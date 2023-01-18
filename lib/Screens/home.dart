import 'package:flutter/material.dart';
import 'package:weatherbee/api/currentapicall.dart';
import 'package:weatherbee/widgets/topbar.dart';
import 'package:weatherbee/widgets/details_widget.dart';
import 'package:weatherbee/widgets/weather_status.dart';
import 'package:weatherbee/widgets/weathercard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String city = "monastir";
  callbackfun(varcity) {
    setState(() {
      city = varcity;
    });
  }

  @override
  void initState() {
    getCurrentWeather(city);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/BG.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                      future: getCurrentWeather(city),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var weather = snapshot.data;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Topbar(
                                currentCity: city,
                                callback: callbackfun,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Weather_status(
                                status: weather.weatherStatus,
                                temp: weather.temperature
                                    .toString()
                                    .split(".")[0],
                                icon: weather.weatherIcon,
                                date: "Mon, 16 Jan",
                                feelsLike:
                                    weather.feelsLike.toString().split(".")[0],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Details(
                                statusdesc: weather.weatherDescription,
                                max: weather.maxTemperature
                                    .toString()
                                    .split(".")[0],
                                min: weather.minTemperature
                                    .toString()
                                    .split(".")[0],
                                humidity:
                                    weather.humidity.toString().split(".")[0],
                                pressure:
                                    weather.pressure.toString().split(".")[0],
                                windSpeed:
                                    weather.windSpeed.toString().split(".")[0],
                                visibility: (weather.visibility / 1000)
                                    .toString()
                                    .split(".")[0],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    const Text(
                      " Weekly forecast:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const <Widget>[
                              WeatherCard(
                                day: "Mon",
                                date: "12 jan",
                                weatherStatus: "sun-cloud-mid-rain",
                                temp: "20",
                                color: "colored",
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              WeatherCard(
                                day: "Tue",
                                date: "13 jan",
                                weatherStatus: "moon-cloud-fast-wind",
                                temp: "18",
                                color: "not colored",
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              WeatherCard(
                                day: "Wed",
                                date: "14 jan",
                                weatherStatus: "sun-cloud-angled-rain",
                                temp: "16",
                                color: "colored",
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              WeatherCard(
                                day: "Thu",
                                date: "15 jan",
                                weatherStatus: "raindrops",
                                temp: "20",
                                color: "not colored",
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              WeatherCard(
                                day: "Fri",
                                date: "16 jan",
                                weatherStatus: "tornado",
                                temp: "20",
                                color: "colored",
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
