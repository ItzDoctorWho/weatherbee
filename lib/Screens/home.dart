import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:weatherbee/api/currentapicall.dart';
import 'package:weatherbee/api/fivedaysforecast.dart';
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
  String city = "tabarka";
  callbackfun(varcity) {
    setState(() {
      city = varcity;
    });
  }

  @override
  void initState() {
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
                                date: DateFormat("E MMM DD").format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        weather.date * 1000)),
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
                    FutureBuilder(
                      future: getfivedaysWeather(city),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var weather = snapshot.data;
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: weather.length,
                              itemBuilder: (context, index) {
                                return WeatherCard(
                                  day: city,
                                  date: weather[index].date,
                                  weatherStatus: weather[index].weatherIcon,
                                  temp: weather[index]
                                      .temperature
                                      .toString()
                                      .split(".")[0],
                                  color: index % 2 == 0 ? 'colored' : 'white',
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 10,
                                );
                              },
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    //future builder that displays rain
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          "Rainmeter",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Snowmeter",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "UVI meter",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    FutureBuilder(
                      future: getCurrentWeather(city),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var weather = snapshot.data;
                          return Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SimpleCircularProgressBar(
                                  valueNotifier: weather.rainVolume != null
                                      ? ValueNotifier(double.parse(
                                          weather.rainVolume.toString()))
                                      : ValueNotifier(0),
                                  mergeMode: true,
                                  maxValue: 5,
                                  progressColors: const [
                                    Color.fromARGB(255, 72, 31, 176),
                                    Color.fromARGB(255, 214, 49, 222),
                                  ],
                                  backColor: Color.fromARGB(120, 89, 89, 90),
                                  onGetText: (double value) {
                                    return Text(
                                      value.toString(),
                                      style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 72, 31, 176),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SimpleCircularProgressBar(
                                  valueNotifier: weather.snowVolume != null
                                      ? ValueNotifier(double.parse(
                                          weather.snowVolume.toString()))
                                      : ValueNotifier(0),
                                  mergeMode: true,
                                  progressColors: const [
                                    Color.fromARGB(255, 72, 31, 176),
                                    Color.fromARGB(255, 214, 49, 222)
                                  ],
                                  backColor: Color.fromARGB(120, 89, 89, 90),
                                  onGetText: (double value) {
                                    return Text(
                                      value.toString(),
                                      style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 72, 31, 176),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SimpleCircularProgressBar(
                                  valueNotifier: weather.uvi != null
                                      ? ValueNotifier(weather.uvi)
                                      : ValueNotifier(0),
                                  mergeMode: true,
                                  progressColors: const [
                                    Color.fromARGB(255, 72, 31, 176),
                                    Color.fromARGB(255, 214, 49, 222)
                                  ],
                                  backColor: Color.fromARGB(120, 89, 89, 90),
                                  onGetText: (double value) {
                                    return Text(
                                      value.toString(),
                                      style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 72, 31, 176),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    )
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
