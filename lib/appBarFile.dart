import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:weather_app/constraints/constants.dart';
import 'package:weather_app/screens/homepage.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/weather.dart';

class appBarFunc extends StatefulWidget {
  appBarFunc({Key? key, required this.width, required this.height})
      : super(key: key);
  final double width, height;
  String city = cityName;

  @override
  State<appBarFunc> createState() => _appBarFuncState();
}

class _appBarFuncState extends State<appBarFunc> {
  final TextEditingController _typeAheadController = TextEditingController();

  // final weatherModel = WeatherModel();
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.blueGrey),
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: IconButton(
                color: kSmallStuffColor,
                onPressed: () {
                  showSimpleNotification(
                    SizedBox(
                        height: 50,
                        child: Text(WeatherModel.getMessage(todaysWeather))),
                    background: Colors.blueGrey,
                    duration: const Duration(seconds: 2),
                    position: NotificationPosition.bottom,
                    elevation: 30,
                  );
                },
                icon: Icon(Icons.recommend),
              ),
            ),
            SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.location_on,
                color: kSmallStuffColor,
              ),
            ),
            SizedBox(width: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.city,
                style: TextStyle(
                  color: kSmallStuffColor,
                  fontSize: 18,
                ),
              ),
            ),
          ]),
        ),
      ),
      SizedBox(width: widget.width * 0.08),
      SizedBox(
          width: widget.width * 0.3,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TypeAheadField(
              animationStart: 0,
              animationDuration: Duration.zero,
              textFieldConfiguration: TextFieldConfiguration(
                controller: this._typeAheadController,
                autofocus: true,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                  labelText: "Location",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              suggestionsBoxDecoration:
                  const SuggestionsBoxDecoration(color: Colors.transparent),
              suggestionsCallback: (pattern) {
                if (pattern.isNotEmpty) {
                  List<String> matches = <String>[];
                  matches.addAll(locSuggestions);

                  matches.retainWhere((s) {
                    return s.toLowerCase().contains(pattern.toLowerCase());
                  });
                  return matches;
                } else {
                  return [];
                }
              },
              itemBuilder: (context, sone) {
                return Card(
                    color: Colors.transparent,
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.all(10),
                      child: Text(sone.toString(),
                          style: TextStyle(color: Colors.white)),
                    ));
              },
              onSuggestionSelected: (suggestion) {
                _typeAheadController.text = suggestion;
                setState(() async {
                  cityName = suggestion;
                  widget.city = cityName;
                  Location().getCityLoc(cityName);
                  var weatherData = await WeatherModel.getCityWeather(cityName);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return homePage(locationWeather: weatherData);
                  }));
                });
              },
            ),
          )),
      // SizedBox(
      //     width: 100,
      //     height: 70,
      //     child: FittedBox(fit: BoxFit.fill, child: SwitchWidget())),
    ]);
  }
}
