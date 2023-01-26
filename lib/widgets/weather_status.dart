import 'package:flutter/material.dart';

// ignore: camel_case_types
class Weather_status extends StatelessWidget {
  const Weather_status({
    Key key,
    this.status,
    this.icon,
    this.date,
    this.temp,
    this.feelsLike,
    this.unit,
  }) : super(key: key);
  final String status;
  final String icon;
  final String date;
  final String temp;
  final String feelsLike;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      child: Material(
        elevation: 10,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [
                    Color.fromARGB(255, 72, 31, 176),
                    Color.fromARGB(255, 214, 49, 222),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
            ),
            Positioned(
              bottom: 60,
              right: 25,
              child: Text(
                "$temp°",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 90,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              right: 40,
              child: Text(
                unit == "metric"
                    ? "Feels like $feelsLike° C"
                    : "Feels like $feelsLike° F",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
            Positioned(
              bottom: 35,
              left: 30,
              child: Text(
                status,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              left: 30,
              child: Text(
                date,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              right: 165,
              child: Image.asset('assets/raindropss.png',
                  height: 200, width: 200, fit: BoxFit.cover),
            ),
          ],
        ),
      ),
    );
  }
}
