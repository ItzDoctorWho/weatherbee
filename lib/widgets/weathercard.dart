import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard(
      {Key key, this.day, this.date, this.weatherStatus, this.temp, this.color})
      : super(key: key);
  final String day;
  final String date;
  final String weatherStatus;
  final String temp;
  final String color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Material(
        elevation: 10,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: color == "colored"
                    ? [
                        const Color.fromARGB(255, 72, 31, 176),
                        const Color.fromARGB(255, 214, 49, 222),
                      ]
                    : [
                        const Color.fromARGB(255, 242, 242, 242),
                        const Color.fromARGB(255, 255, 255, 255),
                      ],
              )),
          child: Card(
            color: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: SizedBox(
              width: 90,
              height: 200,
              child: Center(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    day,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: color == "colored"
                          ? Colors.white
                          : Colors.black.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color == "colored"
                          ? Colors.white
                          : Colors.black.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Image.asset("assets/$weatherStatus.png",
                      height: 70, width: 70),
                  Text(
                    "$temp°",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: color == "colored"
                          ? Colors.white
                          : Colors.black.withOpacity(0.5),
                    ),
                  ),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
