import 'dart:core';
import 'package:flutter/material.dart';

import 'constraints/constants.dart';

class bigWeatherCard extends StatelessWidget {
  const bigWeatherCard({
    Key? key,
    required this.temp,
    required this.day,
    required this.weatherIcon,
    required this.realFeel,
    required this.wind,
    required this.sunrise,
    required this.sunset,
  }) : super(key: key);
  final String temp, day, realFeel, sunrise, sunset, wind;
  final Icon weatherIcon;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {},
        child: SizedBox(
          width: 250,
          height: 250,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      day,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(temp,
                      style:
                          TextStyle(fontSize: 80, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: weatherIcon,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Real Feel: " + realFeel,
                          style: kCardSmallTextStyle,
                        ),
                        Text(
                          "Wind: " + wind + "km/h",
                          style: kCardSmallTextStyle,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text("Sunrise: " + sunrise, style: kCardSmallTextStyle),
                        Text("Sunset: " + sunset, style: kCardSmallTextStyle),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
