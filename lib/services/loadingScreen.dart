import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/homepage.dart';
import 'package:weather_app/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel.getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return homePage(locationWeather: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 100.0,
          // controller: AnimationController(
          //   duration: const Duration(seconds: 15),
          //   vsync: this,
          // ),
        ),
      ),
    );
  }
}
