import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import '../constraints/constants.dart';
import 'networking.dart';
import 'location.dart';

class WeatherModel {
  static Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  static Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${lat}&lon=${long}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  static void changeBackground(int condition) {
    if (condition < 700) {
      backImage = "assets/rainy.jpg";
    } else if (condition == 800) {
      backImage = "assets/sunny.jpg";
    } else if (condition <= 804) {
      backImage = "assets/cloudy.jpeg";
    } else {
      print(condition);
      backImage = "assets/darkimage.jpeg";
    }
  }

  static Icon getWeatherIcon(int condition) {
    if (condition < 300) {
      return const Icon(WeatherIcons.thunderstorm, size: 50);
    } else if (condition < 400) {
      return const Icon(WeatherIcons.rain_mix, color: Colors.white, size: 50);
    } else if (condition < 600) {
      return const Icon(WeatherIcons.raindrops, color: Colors.white, size: 50);
    } else if (condition < 700) {
      return const Icon(WeatherIcons.snow, color: Colors.white, size: 50);
    } else if (condition < 800) {
      return const Icon(WeatherIcons.smoke, color: Colors.white, size: 50);
    } else if (condition == 800) {
      return const Icon(WeatherIcons.day_sunny,
          color: Colors.yellowAccent, size: 50);
    } else if (condition <= 804) {
      return const Icon(WeatherIcons.cloud, color: Colors.white, size: 50);
    } else {
      return const Icon(WeatherIcons.alien, color: Colors.red);
    }
  }

  static String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a jacket just in case';
    }
  }
}
