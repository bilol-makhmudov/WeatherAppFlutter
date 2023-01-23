import 'package:flutter/material.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';
import 'package:weather_app/appBarFile.dart';
import '../cards.dart';
import '../constraints/constants.dart';
import '../services/weather.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/map.dart';

class homePage extends StatefulWidget {
  homePage({Key? key, this.locationWeather}) : super(key: key);
  late final locationWeather;

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final ScrollController _fController = ScrollController();
  List<bigWeatherCard> weatherList = [];
  late Icon weatherIcon;
  late int temperature;
  late String day, date, sunset, sunrise;
  late double wind, realFeel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        cityName = '';
        weatherIcon = const Icon(Icons.dangerous);
      }
      todaysWeather = weatherData['list'][0]['main']['temp'].toInt();
      for (int i = 0; i < 40; i += 8) {
        var condition = weatherData['list'][i]['weather'][0]['id'];
        double temp = weatherData['list'][i]['main']['temp'];
        temperature = temp.toInt();
        weatherIcon = WeatherModel.getWeatherIcon(condition);
        cityName = weatherData["city"]["name"];

        realFeel = weatherData['list'][i]['main']['feels_like'];
        wind = weatherData['list'][i]['wind']['speed'];
        date = weatherData['list'][i]['dt_txt'];
        day = weekDays[DateTime.parse(date).weekday - 1];
        sunrise = timeFormatter(weatherData["city"]["sunrise"]);
        sunset = timeFormatter(weatherData["city"]["sunset"]);

        // temperature = 12;
        // cityName = "AFs";
        // realFeel = 12.3;
        // wind = 12.3;
        // date = 'asdf';
        // day = 'asdf';
        // sunset = 'asdf';
        // sunrise = 'asdf';
        // print(weekDays[DateTime.parse(date).weekday]);
        weatherList.addAll([
          bigWeatherCard(
            temp: temperature.toString(),
            wind: wind.toString(),
            weatherIcon: weatherIcon,
            day: day,
            realFeel: realFeel.toString(),
            sunrise: sunrise,
            sunset: sunset,
          ),
        ]);
        WeatherModel.changeBackground(
            weatherData['list'][0]['weather'][0]['id']);
      }
    });
  }

  String timeFormatter(int timeStamp) {
    var dt = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat('HH:MM').format(dt).toString();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backImage), fit: BoxFit.cover)),
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                appBarFunc(width: width, height: height,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Next 5 days",
                              style: TextStyle(
                                  color: kSmallStuffColor, fontSize: 25)),
                        ),
                      )),
                ),
                SizedBox(
                    height: 250,
                    child: VsScrollbar(
                      // radius: Radius.circular(25),
                      // thumbColor: Colors.white,
                      // trackColor: Colors.white,
                      // trackBorderColor: Colors.white10,
                      controller: _fController,
                      isAlwaysShown: true,
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(25)),
                      // thumbVisibility: true,
                      // trackVisibility: true,
                      // thickness: 5,
                      style: VsScrollbarStyle(
                          color: Colors.white,
                          radius: Radius.circular(25),
                          hoverThickness: 5),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(3),
                        physics: BouncingScrollPhysics(),
                        controller: _fController,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(children: [
                            weatherList[index],
                          ]);
                        },
                      ),
                    )),
                // SizedBox(
                //     height: 250,
                //     child: RawScrollbar(
                //       thumbColor: Colors.white,
                //       trackColor: Colors.white10,
                //       trackBorderColor: Colors.white10,
                //       controller: _fController,
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(25)),
                //       thumbVisibility: true,
                //       trackVisibility: true,
                //       thickness: 5,
                //       child: ListView.builder(
                //           padding: EdgeInsets.all(3.0),
                //           scrollDirection: Axis.horizontal,
                //           controller: _fController,
                //           itemCount: weatherList.length,
                //           itemBuilder: (BuildContext context, int index) {
                //             return Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: ListTile(title: weatherList[index]));
                //           }),
                //     )),,
                Map(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
